//
//  SavedViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//

import Foundation
import FirebaseAuth

class SavedViewModel{
    
    let dbManager = SavedArticleManager()
    let auth = AuthManager()
    let currentUser = Auth.auth().currentUser

    func loadSavedArticles(completion: @escaping ((_ articles:[ArticleModel])->Void)){
        
        dbManager.fetchSavedArticles{ (articlesArray) in
            completion(articlesArray)
        }
    }
    
    func getUser() -> User?{
        return currentUser
    }
    func deleteArticle(article: ArticleModel){
        dbManager.deleteSavedArticle(article: article)
    }
    
}
