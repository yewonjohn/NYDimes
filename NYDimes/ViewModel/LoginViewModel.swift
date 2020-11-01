//
//  LoginViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/22/20.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import RxSwift
import RxCocoa

class LoginViewModel{
    let authManager = AuthManager()
    
    func signInNormally(vc: UIViewController, emailText: String?, passwordText: String?) {
        if let email = emailText, let password = passwordText{
            authManager.login(viewController: vc, email: email, password: password)
        }
    }
    
    func appleSignIn(viewController: UIViewController){
        authManager.loginApple(viewController: viewController)
    }
    
    func authorizeAppleFirebase(credential: ASAuthorizationAppleIDCredential, completion: @escaping (_ signedIn:Bool)->Void){
        authManager.authorizeAppleFirebase(credential: credential){ (signedIn) in
            completion(signedIn)
        }
    }
    
    func getGoogleObservable() -> BehaviorRelay<Bool> {
        return AuthManager.googleObserverVariable
    }
}
