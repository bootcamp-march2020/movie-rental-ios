//
//  APIManager.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case InvalidURL
}

class APIManager {
    
    static let shared = APIManager()
    
    func makeAPICall(_ url: String, method: String, completion: @escaping (Result<Data, Error>)->()) {
        
    }
    
    func getMoviesList(completion: @escaping (Result<Data, Error>)->()) {
        
    }
    
}
