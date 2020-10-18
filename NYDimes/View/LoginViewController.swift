//
//  ViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/14/20.
//

import UIKit
import GoogleSignIn
import IQKeyboardManager

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var googleSignIn: GIDSignInButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - Properties
    let auth = AuthManager()
    

    // MARK: - User Interactions
    @IBAction func signIn(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            auth.login(viewController: self, email: email, password: password)
        }
    }
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //NavBar Transparancy
        navigationController?.setup()
        //Keyboard Management
        IQKeyboardManager.shared().isEnabled = true
        self.hideKeyboardWhenTappedAround()
        
        //Google Sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().signIn()
    }
    
    func segueToTabBar(){
        print("triggered")
        self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
    }

    


}

