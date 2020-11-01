//
//  MoviesViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/31/20.
//

import Foundation


class MoviesViewModel {
    
    let moviesManager = MovieManager()
    func getMovies(type: String, order: String, completion: @escaping ((_ movies: [MovieModel]) -> Void)){
        moviesManager.getMovieReviews(type: type, order: order){ (moviesResult) in
            completion(moviesResult)
        }
    }
    
    
}
