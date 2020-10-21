//
//  FirebaseManager.swift
//  NYDimes
//
//  Created by John Kim on 10/19/20.
//

import Foundation
import Firebase
import FirebaseFirestore

class SavedArticleManager{
    
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser?.email

    func addToSaved(article: ArticleModel){
        
        let timeStamp = NSDate().timeIntervalSince1970
        let docRef = db.collection("saved")
        
        docRef.getDocuments{ (snapshot, error) in
            if let snapshot = snapshot, let id = article.id {
                self.db.collection("saved").document("\(id)").setData([
                    "user":self.currentUser,
                    "id":article.id,
                    "author": article.author,
                    "url":article.url,
                    "image":article.image?.url,
                    "published":article.published,
                    "updated":article.updated,
                    "title":article.title,
                    "dateAdded":timeStamp
                ]){ (error) in
                    if let e = error{
                        print(e)
                    } else{
                        print("succesfully saved favorites")
                    }
                }
            }
        }
    }
        
    func fetchSavedArticles(completion: @escaping ((_ articles:[ArticleModel])->Void)){
        var articlesArray = [ArticleModel]()
        
        db.collection("saved")
            .whereField("user", isEqualTo: currentUser)
            .order(by: "dateAdded", descending: false)
            .getDocuments{  (QuerySnapshot, Error) in
                if let e = Error{
                    print(e)
                }
                else{
                    if let snapshotDocuments = QuerySnapshot?.documents{
                        for doc in snapshotDocuments{
                            let data = doc.data()
                            
                            var article = ArticleModel()
                            var imageMedia = MediaModel()
                            
                            article.id = data["id"] as? Int
                            article.author = data["author"] as? String
                            article.title = data["title"] as? String
                            imageMedia.url = data["image"] as? String
                            article.image = imageMedia
                            article.url = data["url"] as? String
                            
                            articlesArray.append(article)
                            
                        }
                    }
                    completion(articlesArray)
                }
            }
        
        
        
    }
}
