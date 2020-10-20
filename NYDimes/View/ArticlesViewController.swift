//
//  ArticlesViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit

class ArticlesViewController: UIViewController{
    
    //MARK:- IBOutlets
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    //MARK:- Properties
    let viewModel = ArticlesViewModel()
    var listOfArticles = [ArticleModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getArticles("viewed", 1){ (articleArray) in
            self.listOfArticles = articleArray
            self.articleCollectionView.reloadData()
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/3, height: view.frame.size.height/3)
        
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        
    }
    
//    @objc func saveButtonClicked(sender: UIButton){
//        print("button Clicked")
////        pulse(button: saveButton)
//    }
    
    
    
}

//MARK:- CollectionView Data Source
extension ArticlesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        //datasource for all cell properties
        cell.configureImage(with: #imageLiteral(resourceName: "exampleBackground2"))
        cell.configureTitle(with: listOfArticles[indexPath.row].title ?? "No Title")
        cell.configureButton()
        cell.configureAuthors(authors: listOfArticles[indexPath.row].author ?? "Authors Unknown")
        
        return cell
    }

    @objc func saveButtonClicked(){
        print("button Clicked")
//        pulse(button: saveButton)
    }
}


//MARK: - CollectionView Delegate Framing Layout
extension ArticlesViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.3)

    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//       return UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
//    }
}

extension ArticlesViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let url = URL(string: (listOfArticles[indexPath.row].url!)) else { return }
//        UIApplication.shared.open(url)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselectie")
    }
    
}
