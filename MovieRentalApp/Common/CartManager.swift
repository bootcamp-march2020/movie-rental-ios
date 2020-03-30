//
//  CartManager.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

let CartItemDidChangeNotification = Notification.Name("CartItemDidChangeNotification")

class CartManager: CartManagerProtocol {
    
    static let shared = CartManager()
    
    weak var valueUpdater: CartValueUpdator?
    var moviesInCart: [MovieModel] = []
    
    func addMovie(movie: MovieModel) {
        moviesInCart.append(movie)
        valueUpdater?.showCartCount(moviesInCart.count)
        NotificationCenter.default.post(name: CartItemDidChangeNotification, object: nil)
    }
    
    func removeMovie(movie: MovieModel) {
        moviesInCart.removeAll { (movieModel) -> Bool in
            movie.id == movieModel.id
        }
        valueUpdater?.showCartCount(moviesInCart.count)
        NotificationCenter.default.post(name: CartItemDidChangeNotification, object: nil)
    }
    
}
