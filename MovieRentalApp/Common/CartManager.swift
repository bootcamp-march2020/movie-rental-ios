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
    var moviesInCart: [MovieModel] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: CartItemDidChangeNotification, object: nil)
                self.valueUpdater?.showCartCount(self.moviesInCart.count)
            }
        }
    }
    
    func addMovie(movie: MovieModel) {
        moviesInCart.append(movie)
    }
    
    func removeMovie(movie: MovieModel) {
        moviesInCart.removeAll { (movieModel) -> Bool in
            movie.id == movieModel.id
        }
    }
    
    func updateOutOfStockMovies(movieIds: [Int]) {
        moviesInCart = moviesInCart.map({ (movie) -> MovieModel in
            if movieIds.contains(movie.id) {
                return movie.updateOutOfStock(value: true)
            }
            return movie
        })
    }
    
}
