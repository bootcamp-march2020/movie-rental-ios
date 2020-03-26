
//
//  CartManagerProtocol.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol CartManagerProtocol: ClassProtocol {
    var moviesInCart: [MovieModel] {get}
    func addMovie(movie: MovieModel)
    func removeMovie(movie: MovieModel)
}
