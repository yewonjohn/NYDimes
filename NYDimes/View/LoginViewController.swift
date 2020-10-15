//
//  ViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/14/20.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet var GoogleSignIn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Google Sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
     
//        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//          // ...
//          if let error = error {
//            // ...
//            return
//          }
//
//          guard let authentication = user.authentication else { return }
//          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                            accessToken: authentication.accessToken)
//            Auth.auth().signIn(with: credential) { (authResult, error) in
//              if let error = error {
//                let authError = error as NSError
//                if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
//                  // The user is a multi-factor user. Second factor challenge is required.
//                  let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//                  var displayNameString = ""
//                  for tmpFactorInfo in (resolver.hints) {
//                    displayNameString += tmpFactorInfo.displayName ?? ""
//                    displayNameString += " "
//                  }
//                  self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
//                    var selectedHint: PhoneMultiFactorInfo?
//                    for tmpFactorInfo in resolver.hints {
//                      if (displayName == tmpFactorInfo.displayName) {
//                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
//                      }
//                    }
//                    PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
//                      if error != nil {
//                        print("Multi factor start sign in failed. Error: \(error.debugDescription)")
//                      } else {
//                        self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
//                          let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
//                          let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
//                          resolver.resolveSignIn(with: assertion!) { authResult, error in
//                            if error != nil {
//                              print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
//                            } else {
//                              self.navigationController?.popViewController(animated: true)
//                            }
//                          }
//                        })
//                      }
//                    }
//                  })
//                } else {
//                  self.showMessagePrompt(error.localizedDescription)
//                  return
//                }
//                // ...
//                return
//              }
//              // User is signed in
//              // ...
//            }
//        }
        
        
        
        
        
        
    }



}

