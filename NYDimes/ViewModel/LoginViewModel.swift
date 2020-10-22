//
//  LoginViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/22/20.
//

import Foundation
import FirebaseAuth
import AuthenticationServices

class LoginViewModel{
    let authManager = AuthManager()
    
    
    func appleSignIn(viewController: UIViewController){
        authManager.loginApple(viewController: viewController)
    }
    
    func authorizeAppleFirebase(credential: ASAuthorizationAppleIDCredential, completion: @escaping (_ signedIn:Bool)->Void){
        authManager.authorizeAppleFirebase(credential: credential){ (signedIn) in
            completion(signedIn)
        }
                                                                    
        
        
    }
}
