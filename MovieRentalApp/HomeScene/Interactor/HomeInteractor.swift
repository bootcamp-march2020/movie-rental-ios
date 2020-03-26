//
//  HomeInteractor.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    let jsonManager: JSONManager
    let apiManager: APIManager
    
    convenience init() {
        self.init(apiManager: APIManager.shared,
                  jsonManager: JSONManager.shared)
    }
    
    init(apiManager: APIManager, jsonManager: JSONManager) {
        self.jsonManager = jsonManager
        self.apiManager = apiManager
    }
    
    
    func getMovieList(completion: @escaping (Result<[MovieModel], Error>) -> ()) {
        apiManager.getMoviesList { result in
            switch result {
            case let .success(data):
                do {
                    let movies = try self.jsonManager.parseMovies(from: data)
                    completion(.success(movies))
                }
                catch {
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
}
