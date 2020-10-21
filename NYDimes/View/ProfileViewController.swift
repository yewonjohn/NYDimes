//
//  ProfileViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/19/20.
//

import UIKit

class ProfileViewController: UIViewController{
    //MARK:- Outlets
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    //MARK:- Properties
    var accountSettingsLabel = [String]()
    var accountSettingsImages = [UIImage]()
    
    let profileViewModel = ProfileViewModel()
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountSettingsLabel = Const.accountSettingsLabel
        accountSettingsImages = Const.accountSettingsImages
        
        setHelloLabel()
        setLoginText()
        configTableView()

    }
    //MARK:- Configurations
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SettingsCell.identifier, bundle: nil), forCellReuseIdentifier: SettingsCell.identifier)
        tableView.layer.cornerRadius = 30
        
        tableViewHeight.constant = view.frame.height * 0.4
    }
    
    func setHelloLabel(){
        guard let displayName = profileViewModel.getCurrentUser()?.displayName else {return}
        helloLabel.text = "hello, \(displayName)"
    }
    
    func setLoginText(){
        if((profileViewModel.getCurrentUser()) == nil){
            accountSettingsLabel[4] = "Sign In"
            accountSettingsImages[4] = #imageLiteral(resourceName: "Login")
        }
    }
    
    
    
}

//MARK: -- TableView DataSource and Delegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountSettingsLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        
        if(indexPath.row != 4){
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: accountSettingsLabel[indexPath.row])
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.settingsImage.image = accountSettingsImages[indexPath.row]
            cell.settingsLabel.attributedText = attributeString
            return cell
        }else{
            cell.settingsLabel.text = accountSettingsLabel[indexPath.row]
            cell.settingsImage.image = accountSettingsImages[indexPath.row]
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height * 0.4)/5
    }
    
    //Takes user to yelp page of selected favorite item.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //deselects after selecting
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.row == 4){
            if(profileViewModel.getCurrentUser() != nil){
                let alert = UIAlertController(title: "Logout?", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default))
                alert.addAction(UIAlertAction(title: "Yes, logout", style: .destructive, handler: { action in
                    switch action.style{
                    case .default:
                        print("cancel")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        self.profileViewModel.signOut()
                        self.navigationController?.popToRootViewController(animated: true)
                    }}))
                
                self.present(alert, animated: true, completion: nil)
                } else{
                    self.navigationController?.popToRootViewController(animated: true)
                }
        }
    }
}
