//
//  SavedViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//

import Foundation

class SavedViewModel{
    
    let dbManager = SavedArticleManager()
    
    func loadSavedArticles(completion: @escaping ((_ articles:[ArticleModel])->Void)){
        
        dbManager.fetchSavedArticles{ (articlesArray) in
            completion(articlesArray)
        }
        
    }
    
}
