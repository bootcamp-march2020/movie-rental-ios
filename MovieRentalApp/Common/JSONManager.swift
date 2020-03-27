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
    
    func parseCheckoutMovies(from obj: Any) throws -> [CheckoutMovie] {
        guard let json = obj as? [String: Any] else { throw JSONError.ResponseFormatError }
        guard let cartItemLists = json["cartItemList"] as? [[String: Any]] else { throw JSONError.ResponseFormatError }
        return cartItemLists.map { parseCheckoutMovie(from: $0) }
    }
    
    func parseCheckoutMovie(from dict: [String: Any]) -> CheckoutMovie {
        let movieDetails = dict["movie"] as? [String: Any] ?? [:]
        let id = movieDetails["id"] as? Int ?? 0
        let name = movieDetails["title"] as? String ?? ""
        let numberOfDays = dict["numberOfDays"] as? Int ?? 0
        let cost = dict["cost"] as? Double ?? 0
        return CheckoutMovie(mid: id, movieName: name, numberOfDays: numberOfDays, cost: cost, posterUrl: nil, pricingModel: nil)
    }
    
}
