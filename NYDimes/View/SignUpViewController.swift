//
//  SignUpViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit
import IQKeyboardManager

class SignUpViewController : UIViewController{
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Properties
    let auth = AuthManager()
    
    // MARK: - User Interactions
    @IBAction func signUp(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
                auth.register(viewController: self, email: email, password: password, name: nameTextField.text ?? "")
        }
    }
    @IBAction func popToSignIn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        //NavBar Transparancy
        navigationController?.setup()
        //Keyboard Management
        IQKeyboardManager.shared().isEnabled = true
        self.hideKeyboardWhenTappedAround()
    }
    
}
