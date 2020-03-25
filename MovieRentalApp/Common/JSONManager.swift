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
    
    func parseMovies(from data: Data) throws -> [MovieModel] {
        return []
    }
    
    func parseMovie(from dict: [String: Any]) throws -> MovieModel {
        throw JSONError.ParsingFailed
    }
    
}
