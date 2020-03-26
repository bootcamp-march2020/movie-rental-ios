//
//  JSONManager.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case ParsingFailed, ResponseFormatError
}


class JSONManager {
    
    static let shared = JSONManager()
    
    func convertToJSONObject(from data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
    
    func parseMovies(from data: Data) throws -> [MovieModel] {
        let obj = try convertToJSONObject(from: data)
        guard let json = obj as? [[String: Any]] else { throw JSONError.ResponseFormatError }
        return json.map { parseMovie(from: $0) }
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
