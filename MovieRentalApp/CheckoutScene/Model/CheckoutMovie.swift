//
//  CheckoutMovie.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

struct CheckoutMovie {
    let mid: Int
    let movieName: String
    let numberOfDays: Int
    let cost: Double
    var posterUrl: String?
    var pricingModel: PricingModel?
    
    func updatePosterUrl(_ url: String, andPricing model: PricingModel) -> CheckoutMovie {
        var copy = self
        copy.posterUrl = url
        copy.pricingModel = model
        return copy
    }
}
