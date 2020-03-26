//
//  MovieModel.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

struct MovieModel: Equatable {
    let id: String
    let name: String
    let posterUrlString: String
    let ratings: String
    
    static func ==(lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id
    }
}
