//
//  MovieModel.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

struct MovieModel: Equatable {
    let id: Int
    let name: String
    let posterUrlString: String
    let ratings: Double
    let pricing: PricingModel
    
    static func ==(lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct PricingModel {
    let id: Int
    let name: String
    let initialCostString: String
    let additionalCostString: String
    
    var formattedPricing: String {
        return initialCostString + "\n" + additionalCostString
    }
}
