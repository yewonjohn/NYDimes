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
            if let snapshot = snapshot {
                
                self.db.collection("saved").document("\(article.id)").setData([
                    "user":self.currentUser,
                    "id":article.id,
                    "author": article.author,
                    "url":article.url,
                    "image":article.image,
                    "published":article.published,
                    "updated":article.updated,
                    "dateAdded":timeStamp
                ]){ (error) in
                    if let e = error{
//                        self.delegate?.didFailAddingFavorites(error: e)
                        print(e)
                    } else{
                        print("succesfully saved favorites")
                    }
                }
                
            }
            
        }
        
        func getSavedList(){
            
            var savedArray = [ArticleModel]()
            
            db.collection("saved")
                .whereField("user", isEqualTo: currentUser)
                .order(by: "dateAdded", descending: false)
                .getDocuments{ (QuerySnapshot,Error) in
                    if let e = Error{
                        //handle error fetching here
                    }
                    else{
                        if let snapshotDocuments = QuerySnapshot?.documents{
                            for doc in snapshotDocuments{
                                let data = doc.data()
                                
                                var article = ArticleModel()
                                article.id = data["id"] as? Int
                                article.author = data["author"] as? String
                                article.url = data["url"] as? String
                                article.published = data["published"] as? String
                                article.updated = data["updated"] as? String
                                var mediaImg = MediaModel()
                                mediaImg.url = data["image"] as? String
                                article.image = mediaImg
                                
                                savedArray.append(article)
                            }
                            
                        }
                    }
                }
            
            
            
            //                    "user":self.currentUser,
//            "id":article.id,
//            "author": article.author,
//            "url":article.url,
//            "image":article.image,
//            "published":article.published,
//            "updated":article.updated,
        }

    }
    
    
}
