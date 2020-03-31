//
//  CartPresenter.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

class CartPresenter: CartPresenterProtocol {
    
    weak var viewController: CartViewControllerProtocol?
    lazy var interactor: CartInteractorProtocol = CartInteractor()
    
    func handleCartCheckout(for items: [MovieModel], rentalDict: [Int: Int]) {
        viewController?.showLoading(true)
        interactor.checkoutItems(rentalDict: rentalDict) { result in
            DispatchQueue.main.async { self.viewController?.showLoading(false) }
            switch result {
            case let .success(checkoutMovies):
                var checkoutMovieModel = checkoutMovies
                if !checkoutMovieModel.outOfStockMovies.isEmpty {
                    DispatchQueue.main.async {
                        self.viewController?.showAlert()
                    }
                } else {
                    var cMovies = checkoutMovieModel.moviesList
                    (0 ..< cMovies.count).forEach { index in
                        if let movie = items.first(where: { $0.id == cMovies[index].mid }) {
                            cMovies[index].posterUrl = movie.posterUrlString
                            cMovies[index].pricingModel = movie.pricing
                        }
                    }
                    checkoutMovieModel.moviesList = cMovies
                    DispatchQueue.main.async {
                        self.viewController?.showCheckout(for: checkoutMovieModel)
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
