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
    let articleAPI = ArticleManager()
    var listOfArticles = [ArticleModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleAPI.getArticles(type: "viewed", days: 1){ (articleArray) in
            self.listOfArticles = articleArray
            self.articleCollectionView.reloadData()
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/3, height: view.frame.size.height/3)
        
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(ArticleCells.self, forCellWithReuseIdentifier: "ArticleCells")
        
    }
    
}
//MARK:- CollectionView Data Source
extension ArticlesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(listOfArticles.count)
        return listOfArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCells", for: indexPath) as! ArticleCells
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        return cell
    }
}

//MARK: - CollectionView Delegate Framing Layout
//extension ArticlesViewController: UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: collectionView.frame.height * 0.6, height: collectionView.frame.height * 0.9)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//       return UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
//    }
//}

extension ArticlesViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("touchie touchie")
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselectie")
    }
    
}
