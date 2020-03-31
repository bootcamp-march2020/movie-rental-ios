//
//  CartInteractor.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

class CartInteractor: CartInteractorProtocol {

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
    
    func checkoutItems(movies: [MovieModel], rentalDict: [Int: Int], completion: @escaping (Result<CheckoutMoviesSceneModel, Error>)->()) {
        do {
            let data = try jsonManager.getBodyDataFor(rentalDict: rentalDict)
            apiManager.checkoutItems(bodyData: data) { result in
                switch result {
                case let .success(json):
                    do {
                        let checkoutSceneModal = try self.jsonManager.parseCheckoutMovies(from: json, movies: movies)
                        completion(.success(checkoutSceneModal))
                    }
                    catch {
                        if case let CheckoutError.OutOfStock(movieIds) = error {
                            CartManager.shared.updateOutOfStockMovies(movieIds: movieIds)
                        }
                        completion(.failure(error))
                    }
                    
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
    }
    
}
