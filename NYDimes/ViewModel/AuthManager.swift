//
//  AuthManager.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import Foundation
import FirebaseAuth

//Firebase calls to all Authentication related tasks
class AuthManager{
    
    let userDefault = UserDefaults.standard
    
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
    
    func getDisplayName() -> String?{
        let displayName = Auth.auth().currentUser?.displayName
        
        return displayName
    }
    
    
}
