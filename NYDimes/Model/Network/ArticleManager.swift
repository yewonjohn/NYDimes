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
    
    func getArticles(type: String, days: Int, completion: @escaping ((_ articles:[ArticleModel])->Void)) {
        
        var resultArticles = [ArticleModel]()
        let apiKey = "xhCbQFpLJv0wgUALuxi21dzp3pl873cb"
        let url = "https://api.nytimes.com/svc/mostpopular/v2/\(type)/\(days).json?api-key=\(apiKey)"
        
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
    //MARK:-- IMPLEMENTING URLSESSION FOR PRACTICE
    func getArticlesURLSession(type: String, days: Int, completion: @escaping ((_ articles:[ArticleModel])->Void)){
        var resultArticles = [ArticleModel]()
        let apiKey = "xhCbQFpLJv0wgUALuxi21dzp3pl873cb"

        let session = URLSession.shared
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/\(type)/\(days).json?api-key=\(apiKey)")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check the response
            print(response)
            // Check if an error occured
            if error != nil {
            // HERE you can manage the error
                print(error)
                return
            }
            // Serialize the data into an object
            do {
                
                let json = try JSONDecoder().decode(ArticleResults.self, from: data! )
                    //try JSONSerialization.jsonObject(with: data!, options: [])
                completion(resultArticles)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
                    
            })
        task.resume()
    }
}
