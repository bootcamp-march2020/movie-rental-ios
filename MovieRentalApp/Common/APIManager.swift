//
//  APIManager.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case InvalidURL, DataIsNil
}

class APIManager {
    
    static let shared = APIManager()
    
    func makeAPICall(_ url: String, completion: @escaping (Result<Data, Error>)->()) {
        guard let url = URL.init(string: url) else {
            completion(.failure(NetworkError.InvalidURL))
            return
        }
        let request = URLRequest.init(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.DataIsNil))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
