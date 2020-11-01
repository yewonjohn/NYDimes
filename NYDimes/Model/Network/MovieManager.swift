//
//  MovieManager.swift
//  NYDimes
//
//  Created by John Kim on 10/31/20.
//

import Foundation


class MovieManager {
    
    
    
    //MARK:-- Properties
    fileprivate let apiKey = Const.API.apiKey

    
    func getMovieReviews(type: String, order: String, completion: @escaping ((_ movies:[MovieModel])->Void)){
        
        let session = URLSession.shared
        let url = URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/\(type)/\(order).json?&api-key=\(apiKey)")!
        
//        var resultMovies = [MovieModel]()
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check the response
//            print(response)
            // Check if an error occured
            if error != nil {
            // HERE you can manage the error
                print(error)
                return
            }
            // Serialize the data into an object
            do {
                
                let json = try JSONDecoder().decode(MovieJSONResults.self, from: data!)
                    //try JSONSerialization.jsonObject(with: data!, options: [])
                if let result = json.results {
                    completion(result)
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
                    
            })
        task.resume()
        
        
        
    }

    
    
    
    
    
}
