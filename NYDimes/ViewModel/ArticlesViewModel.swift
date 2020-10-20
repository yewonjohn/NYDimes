//
//  ArticlesViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/18/20.
//

import Foundation

class ArticlesViewModel{
    let articleAPI = ArticleManager()

    func getArticles(_ type: String, _ days: Int, completion: @escaping ((_ articles:[ArticleModel])->Void)){
        articleAPI.getArticles(type: type, days: days){ (articleArray) in
            completion(articleArray)
        }
    }
    






}

