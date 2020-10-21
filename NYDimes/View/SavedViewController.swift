//
//  SavedViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/19/20.
//

import UIKit

class SavedViewController : UIViewController{
    //MARK:-- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:-- Properties
    let viewModel = SavedViewModel()
    var listOfArticles = [ArticleModel]()
    
    //MARK:-- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SavedCell", bundle: nil), forCellReuseIdentifier: "SavedCell")

        
        viewModel.loadSavedArticles{ (articlesArray) in
            
            DispatchQueue.main.async {
                self.listOfArticles = articlesArray
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    
}
//MARK:-- TableView DataSource
extension SavedViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfArticles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! SavedCell
        cell.articleTitle.text = listOfArticles[indexPath.row].title
        cell.articleAuthor.text = listOfArticles[indexPath.row].author
        
        //fetching image using kingfisher
        let url = URL(string: listOfArticles[indexPath.row].image?.url ?? "")
        cell.articleImage.
        
        
        return cell
    }



}

//MARK:-- TableView Delegate
extension SavedViewController : UITableViewDelegate{
    
    
}


