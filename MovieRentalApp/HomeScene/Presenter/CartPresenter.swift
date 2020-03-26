//
//  CartPresenter.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

class CartPresenter: CartManagerProtocol {
    var moviesInCart: [MovieModel] = []
    
    func addMovie(movie: MovieModel) {
        moviesInCart.append(movie)
    }
    
    func removeMovie(movie: MovieModel) {
        moviesInCart.removeAll { (movieModel) -> Bool in
            movie.id == movieModel.id
        }
    }
    
}
