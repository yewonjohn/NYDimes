//
//  ArticlesViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/18/20.
//

import Foundation
import Firebase


class ArticlesViewModel{
    
    let articleAPI = ArticleManager()
    let articleDB = SavedArticleManager()

    func getArticles(_ type: String, _ days: Int, completion: @escaping ((_ articles:[ArticleModel])->Void)){
        articleAPI.getArticles(type: type, days: days){ (articleArray) in
            completion(articleArray)
        }
    }
    
    func getArticlesURLSession(_ type: String, _ days: Int, completion: @escaping ((_ articles:[ArticleModel])->Void)){
        articleAPI.getArticlesURLSession(type: type, days: days){ (articleArray) in
            completion(articleArray)
        }
    }
    
    func saveArticle(article: ArticleModel){
        articleDB.addToSaved(article: article)
    }
    






}

