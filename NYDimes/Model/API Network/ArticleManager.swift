//
//  NYTimesAPI.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class ArticleManager {
    
    func getArticles(completion: @escaping ((_ articles:[ArticleModel])->Void)) {
        
        var resultArticles = [ArticleModel]()
        var days = 1
        let apiKey = "xhCbQFpLJv0wgUALuxi21dzp3pl873cb"
        let url = "https://api.nytimes.com/svc/mostpopular/v2/viewed/\(days).json?api-key=\(apiKey)"

        
        AF.request(url,method:.get).validate().responseJSON{ (responseObject) in
            switch responseObject.result{
            case .success:
                let json: JSON = JSON(responseObject.data)
                let articleArray = json["results"].arrayValue
                
                for articleJSON in articleArray {
                    let art = ArticleModel(json: articleJSON)
                    resultArticles.append(art)
                    
                }
                
            case let .failure(error):
                print(error)
            }
                completion(resultArticles)
        }
    }

    
    
    
}
