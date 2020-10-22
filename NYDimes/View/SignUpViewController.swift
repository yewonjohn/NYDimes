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
    
    @IBOutlet weak var nameHeight: NSLayoutConstraint!
    @IBOutlet weak var emailHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordHeight: NSLayoutConstraint!
    @IBOutlet weak var createButtonHeight: NSLayoutConstraint!
    
    
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
        
        adjustHeightDynamically()

    }
    
    func adjustHeightDynamically(){
        nameHeight.constant = view.frame.height * 0.06
        emailHeight.constant = view.frame.height * 0.06
        passwordHeight.constant = view.frame.height * 0.06
        createButtonHeight.constant = view.frame.height * 0.06
    }
    
}
