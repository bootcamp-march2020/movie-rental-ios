
//
//  CheckoutInteractor.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 30/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol CheckoutInteractorProtocol {
    func placeOrder(movieList: [CheckoutMovie], address: String, completion: @escaping (Result<Bool, Error>) -> ())
}

enum CheckoutError: Error {
    case OutOfStock(movieIds: [Int]), InvalidAddress, CartEmpty
}

class CheckoutInteractor: CheckoutInteractorProtocol {
    
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
    
    func placeOrder(movieList: [CheckoutMovie], address: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        do {
            let data = try jsonManager.getOrderApiRequestBody(moviesList: movieList, address: address)
            self.apiManager.placeOrder(bodyData: data) { (result) in
                switch result {
                case let .success(response):
                    if let success = response as? String {
                        completion(.success(success == "Success"))
                    }
                    else if let dict = response as? [String: [Int]],
                        let outOfScopeIds = dict["outOfStockMovieIds"]
                    {
                        completion(.failure(CheckoutError.OutOfStock(movieIds: outOfScopeIds)))
                    }
                    else {
                        completion(.failure(JSONError.ParsingFailed))
                    }
                    
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
}
