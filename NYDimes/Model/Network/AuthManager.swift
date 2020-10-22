//
//  AuthManager.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit
import FirebaseAuth
import AuthenticationServices

//Firebase calls to all Authentication related tasks
class AuthManager{
    
    let userDefault = UserDefaults.standard
    fileprivate var currentNonce: String?
    
    //MARK:-- Standard EMAIL/PASSWORD LOGIN
    func login(viewController: UIViewController, email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if let e = error{
                print(e)
                let alert = UIAlertController(title: "uh oh", message: e.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok sorry", style: .default, handler: { action in}))
                viewController.present(alert, animated: true, completion: nil)
            } else {
                print("Signed In!")
                self.userDefault.set(true, forKey: "usersignedin")
                self.userDefault.synchronize()

                viewController.performSegue(withIdentifier: "LoginToTabBar", sender: self)
            }
        }
    }
    //MARK:-- GOOGLE LOGIN
    func loginGoogle(credential: AuthCredential){
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print(error)
          }else{
            let name = Notification.Name(rawValue: "googleSignedIn")
            self.userDefault.set(true, forKey: "usersignedin")
            self.userDefault.synchronize()
            NotificationCenter.default.post(name: name, object: nil)
          }
        }
    }
    //MARK:-- APPLE LOGIN
    func loginApple(viewController: UIViewController){
        print("loginApple")
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = viewController as! ASAuthorizationControllerDelegate
        authorizationController.presentationContextProvider = viewController as! ASAuthorizationControllerPresentationContextProviding
        
        authorizationController.performRequests()
    }
    
    private func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        print("createAppleIDRequest")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName,.email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        return request
    }
    
    func authorizeAppleFirebase(credential: ASAuthorizationAppleIDCredential, completion: @escaping (_ signedIn:Bool)->Void){
        print("authorizeAppleFirebase")

        guard let nonce = currentNonce else{
            fatalError()
        }
        guard let appleIDToken = credential.identityToken else{
            print("unable to fetch token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else{
            print("unable to serialize token from data: \(appleIDToken.debugDescription)")
            return
        }
        let appleCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        Auth.auth().signIn(with: appleCredential){ (authDataResult, error) in
            if(error != nil){
                print(error?.localizedDescription)
            }
            
            if let user = authDataResult?.user{
                print("successfully signed in with Apple")
                self.userDefault.set(true, forKey: "usersignedin")
                self.userDefault.synchronize()
                completion(true)
            }
            
        }
    }

    
    //MARK:-- REGISTER ACCOUNT w/ email and password
    func register(viewController: UIViewController, email: String, password: String, name: String){
        
        //registering using email + password
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error{
                let alert = UIAlertController(title: "uh oh", message: e.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok sorry", style: .default, handler: { action in }))
                viewController.present(alert, animated: true, completion: nil)
            } else {
                print("user registered!")
                //saving name with change request
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { (error) in
                    print("error saving display name of current user \(error)")
                }
                self.userDefault.set(true, forKey: "usersignedin")
                self.userDefault.synchronize()
                
                viewController.performSegue(withIdentifier: "RegisterToTabBar", sender: self)
            }
        }
    }
    //MARK:-- GET CURRENT ACCOUNT
    func getDisplayName() -> String?{
        let displayName = Auth.auth().currentUser?.displayName
        
        return displayName
    }
    
    func signOut(){
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        self.userDefault.set(false, forKey: "usersignedin")
        self.userDefault.synchronize()
        
        print("signed out")
    }
    
    
}

