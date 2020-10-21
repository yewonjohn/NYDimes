//
//  SavedViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/19/20.
//

import UIKit
import Kingfisher
import SwipeCellKit
import NVActivityIndicatorView

class SavedViewController : UIViewController{
    //MARK:-- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIcon: NVActivityIndicatorView!
    
    //MARK:-- Properties
    let viewModel = SavedViewModel()
    var listOfArticles = [ArticleModel]()
    
    //MARK:-- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configTableView()
        if(viewModel.getUser() != nil){
            getSavedArticles()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(viewModel.getUser() != nil){
            getSavedArticles()
        }else{
            let alert = UIAlertController(title: "oops!", message: "Please login to save articles!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: { action in}))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    //MARK:- Configs
    func getSavedArticles(){
        viewModel.dbManager.delegate = self
        
        viewModel.loadSavedArticles{ (articlesArray) in
            DispatchQueue.main.async {
                self.loadingIcon.stopAnimating()
                self.listOfArticles = articlesArray
                self.tableView.reloadData()
            }
        }
    }
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SavedCell", bundle: nil), forCellReuseIdentifier: "SavedCell")
    }

}
//MARK:-- TableView DataSource
extension SavedViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfArticles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! SavedCell
        //delegate set for CellSwipeKit
        cell.delegate = self
        cell.articleTitle.text = listOfArticles[indexPath.row].title
        cell.articleAuthor.text = listOfArticles[indexPath.row].author
        
        //fetching image using kingfisher
        let url = URL(string: listOfArticles[indexPath.row].image?.url ?? "")
        cell.articleImage.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
}

//MARK:-- TableView Delegate
extension SavedViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: (listOfArticles[indexPath.row].url) as! String) else { return }
        UIApplication.shared.open(url)

    }
    
    
}
//MARK: -- Cell Swipe Delegates
extension SavedViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.viewModel.deleteArticle(article: self.listOfArticles[indexPath.row])
            self.listOfArticles.remove(at: indexPath.row)

        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "trash_icon")
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
//MARK:-- Loading Icon Delegate
extension SavedViewController: SavedArticleManagerDelegate{
    func isLoading() {
        loadingIcon.startAnimating()
    }
    
    
}
