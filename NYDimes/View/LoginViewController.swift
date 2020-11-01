//
//  ViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/14/20.
//

import UIKit
import GoogleSignIn
import IQKeyboardManager
import AuthenticationServices
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var googleSignIn: NYGoogleButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var appleSignIn: UIButton!
    
    @IBOutlet weak var emailHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordHeight: NSLayoutConstraint!
    @IBOutlet weak var signInHeight: NSLayoutConstraint!
    
    
    // MARK: - Properties
//    private let googleKey = Notification.Name(rawValue: "googleSignedIn")
    private let userDefault = UserDefaults.standard
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    private let auth = AuthManager()


    // MARK: - User Interactions
    //for email/pass login
    @IBAction func signIn(_ sender: UIButton) {
        viewModel.signInNormally(vc: self, emailText: emailTextField.text, passwordText: passwordTextField.text)
    }
    //for guest login
    @IBAction func signInAsGuest(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginToTabBar", sender: self)

    }
    //for apple login
    @IBAction func signInAsApple(_ sender: UIButton) {
        viewModel.appleSignIn(viewController: self)
    }
    //for google login
    @objc func googleSegue(notification: NSNotification){
        print("Signed in with Google!")
        self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
    }
    
    // MARK: - LifeCycle Methods
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loginAutomatically()
        setupObserverable()
        configureLayout()
        googleSignConfig()
        layoutConfig()
            
    }

    //MARK:- Configs
    func loginAutomatically(){
        if userDefault.bool(forKey: "usersignedin") {
            self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
        }
    }
    
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
    }
    
    func layoutConfig(){
        //Layout Config
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        
        
        
//        signInHeight.constant = view.frame.height * 0.06
//        emailHeight.constant = view.frame.height * 0.06
//        passwordHeight.constant = view.frame.height * 0.06
    }
    
    func setupObserverable(){
//        googleObserve = viewModel.getGoogleObservable()

        viewModel.getGoogleObservable().asObservable().subscribe(onNext: { [weak self] (didSignIn) in
            guard let self = self else { return }
            print(didSignIn)
            if(didSignIn){
                print(didSignIn)
                self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
            }
        }).disposed(by: disposeBag)
    }

}
//MARK:-- APPLE LOG IN DELEGATES
extension LoginViewController: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential  = authorization.credential as? ASAuthorizationAppleIDCredential{
            viewModel.authorizeAppleFirebase(credential: appleIDCredential){ (signedIn) in
                if(signedIn){
                    self.performSegue(withIdentifier: "LoginToTabBar", sender: self)
                }
            }
        }
    }
    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
}
