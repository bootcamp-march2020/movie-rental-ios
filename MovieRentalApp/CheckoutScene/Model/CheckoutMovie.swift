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
    let posterUrl: String?
    let pricingModel: PricingModel?
}
