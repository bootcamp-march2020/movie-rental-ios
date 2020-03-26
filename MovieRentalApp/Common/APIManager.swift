//
//  APIManager.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case InvalidURL, InvalidUser, DataIsNil
}

class APIManager {
    
    static let shared = APIManager()
    
    var sessionManager: SessionUtilsProtocol.Type = SessionUtils.self
    
    func makeAPICall(with request: URLRequest, completion: @escaping (Result<Data, Error>)->()) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.DataIsNil))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
    
    func makeServerCall(_ url: String, method: String = "GET", completion: @escaping (Result<Data, Error>)->()) {
        
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.InvalidURL))
            return
        }
        
        do {
            let request = try getServerURLRequest(for: url, method: method)
            makeAPICall(with: request, completion: completion)
        }
        catch {
            completion(.failure(error))
        }
    }
    
    func getServerURLRequest(for url: URL, method: String) throws -> URLRequest {
        guard let idToken = sessionManager.getAccessToken() else { throw NetworkError.InvalidUser }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(idToken, forHTTPHeaderField: "id-token")
        return request
    }
    
    func getMoviesList(completion: @escaping (Result<Data, Error>)->()) {
        let movieUrl = "https://tw-onlinestore.herokuapp.com/movies"
        
    }
    
}
