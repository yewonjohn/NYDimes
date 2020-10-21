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
    @IBOutlet var googleSignIn: NYGoogleButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - Properties
    let auth = AuthManager()
    let googleKey = Notification.Name(rawValue: "googleSignedIn")
    let userDefault = UserDefaults.standard


    // MARK: - User Interactions
    @IBAction func signIn(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            auth.login(viewController: self, email: email, password: password)
        }
    }

    @IBAction func signInAsGuest(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginToTabBar", sender: self)

    }
    
    // MARK: - LifeCycle Methods
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userDefault.bool(forKey: "usersignedin") {
            self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
        }
        
        createObservers()
        configureLayout()
        googleSignConfig()
        layoutConfig()

    }
    //MARK:- Configs
    func configureLayout(){
        //NavBar Transparancy
        navigationController?.setup()
        //Keyboard Management
        IQKeyboardManager.shared().isEnabled = true
        self.hideKeyboardWhenTappedAround()
    }
    func googleSignConfig(){
        //Google Sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func layoutConfig(){
        //Layout Config
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.googleSegue(notification:)), name: googleKey, object: nil)
    }
    
    @objc func googleSegue(notification: NSNotification){
        print("Signed in with Google!")
        self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
    }

}

