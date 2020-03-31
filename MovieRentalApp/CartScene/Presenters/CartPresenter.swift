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
        interactor.checkoutItems(movies: items, rentalDict: rentalDict) { result in
            DispatchQueue.main.async {
                self.viewController?.showLoading(false)
                switch result {
                case let .success(checkoutMovieSceneModel):
                        self.viewController?.showCheckout(for: checkoutMovieSceneModel)
                    
                case let .failure(error):
                    if case CheckoutError.OutOfStock(_) = error {
                        self.viewController?.showOutOfStockAlert()
                        return
                    }
                    self.viewController?.showError(error)
                }
            }
        }
    }
    
}
