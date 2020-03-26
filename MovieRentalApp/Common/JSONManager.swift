//
//  JSONManager.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case ParsingFailed
}


class JSONManager {
    
    static let shared = JSONManager()
    
    func parseMovies(from data: Data) -> [MovieModel] {
        var movies: [MovieModel] = []
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let moviesJson = json as? [Any] {
                for movieJson in moviesJson {
                    if let movieDict = movieJson as? [String : Any] {
                        movies.append(parseMovie(from: movieDict))
                    }
                }
            }
        } catch {
            
        }
        return movies
    }
    
    func parseMovie(from dict: [String: Any]) -> MovieModel {
        let mid = dict["mid"] as? String ?? ""
        let name = dict["title"] as? String ?? ""
        let url = dict["posterUrlString"] as? String ?? ""
        let ratings = "Ratings: \(dict["ratings"] as? Double ?? 0)"
        let movie = MovieModel.init(id: mid, name: name, posterUrlString: url, ratings: ratings)
        return movie
    }
    
}
