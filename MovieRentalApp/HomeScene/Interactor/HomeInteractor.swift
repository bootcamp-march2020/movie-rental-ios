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
        let movieUrl = "https://tw-onlinestore.herokuapp.com/movies"
        apiManager.makeAPICall(movieUrl) { (result) in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                completion(.success(self.jsonManager.parseMovies(from: data)))
            }
        }
    }
    
}
