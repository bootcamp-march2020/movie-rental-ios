//
//  MovieModel.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

struct MovieModel {
    let id: String
    let name: String
    let year: Int
    let rated: String
    let posterUrlString: String
    let releaseDate: Date
    let genre: [String]
    let director: String
    let actors: [String]
    let languages: [String]
    let ratings: String
    let type: String
    let price: Double
}
