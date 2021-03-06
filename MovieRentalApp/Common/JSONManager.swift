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
    
    func parseMovies(from obj: Any) throws -> [MovieModel] {
        guard let json = obj as? [[String: Any]] else { throw JSONError.ResponseFormatError }
        return json.map { parseMovie(from: $0) }
    }
    
    func parseMovie(from dict: [String: Any]) -> MovieModel {
        let mid = dict["mid"] as? Int ?? 0
        let name = dict["title"] as? String ?? ""
        let url = dict["posterUrlString"] as? String ?? ""
        let ratings = dict["ratings"] as? Double ?? 0
        let pricingDict = dict["pricingCategory"] as? [String: Any] ?? [:]
        let movie = MovieModel.init(id: mid, name: name, posterUrlString: url, ratings: ratings, pricing: parsePricingModel(from: pricingDict))
        return movie
    }
    
    func parsePricingModel(from dict: [String: Any]) -> PricingModel {
        let id = dict["id"] as? Int ?? 0
        let name = dict["name"] as? String ?? ""
        let initialCostString = dict["initialCostString"] as? String ?? ""
        let additionalCostString = dict["additionalCostString"] as? String ?? ""
        return PricingModel(id: id, name: name, initialCostString: initialCostString, additionalCostString: additionalCostString)
    }
    
    func getBodyDataFor(rentalDict: [Int: Int]) throws -> Data {
        let jsonObject = rentalDict.map { ["movieId": $0.key, "numberOfDays": $0.value] }
        return try JSONSerialization.data(withJSONObject: jsonObject, options: [])
    }
    
    func getOrderApiRequestBody(moviesList: [CheckoutMovie], address: String) throws -> Data {
        let cartItemList = moviesList.map { ["movieId": $0.mid, "numberOfDays": $0.numberOfDays] }
        let jsonObject: [String : Any] = ["cartItemList" : cartItemList, "address": address]
        return try JSONSerialization.data(withJSONObject: jsonObject, options: [])
    }
    
    func parseCheckoutMovies(from obj: Any, movies: [MovieModel]) throws -> CheckoutMoviesSceneModel {
        guard let json = obj as? [String: Any] else { throw JSONError.ResponseFormatError }
        
        if let outOfStockMovieList: [Int] = json["outOfStockMoviesIds"] as? [Int],
            !outOfStockMovieList.isEmpty
        { throw CheckoutError.OutOfStock(movieIds: outOfStockMovieList) }
        
        guard let totalCost = json["totalCost"] as? Double else {
            throw JSONError.ResponseFormatError
        }
        
        guard let cartItemLists = json["cartItemList"] as? [[String: Any]] else { throw JSONError.ResponseFormatError }
        
        let checkOutMovieSceneModel = CheckoutMoviesSceneModel.init(
            moviesList: cartItemLists.map { parseCheckoutMovie(from: $0, movies: movies) },
            totalCost: totalCost
        )
        return checkOutMovieSceneModel
    }
    
    func parseCheckoutMovie(from dict: [String: Any], movies: [MovieModel]) -> CheckoutMovie {
        let movieDetails = dict["movie"] as? [String: Any] ?? [:]
        let id = movieDetails["id"] as? Int ?? 0
        let name = movieDetails["title"] as? String ?? ""
        let numberOfDays = dict["numberOfDays"] as? Int ?? 0
        let cost = dict["cost"] as? Double ?? 0
        
        if let movie = movies.first(where: { $0.id == id }) {
            return CheckoutMovie(mid: id, movieName: name, numberOfDays: numberOfDays, cost: cost, posterUrl: movie.posterUrlString, pricingModel: movie.pricing)
        }
        
        return CheckoutMovie(mid: id, movieName: name, numberOfDays: numberOfDays, cost: cost, posterUrl: nil, pricingModel: nil)
    }
    
}
