//
//  CheckoutPresenter.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 30/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol CheckoutViewControllerProtocol: ClassProtocol {
    func showSuccessScreen()
    func showCartWithOutOfStockMovies(_ movieIds: [Int])
    func showError(message: String)
}

class CheckoutPresenter {
    
    weak var viewController: CheckoutViewControllerProtocol?
    lazy var interactor: CheckoutInteractorProtocol = CheckoutInteractor()
    
    func placeOrder(movies: [CheckoutMovie], address: String) {
        interactor.placeOrder(movieList: movies, address: address) { result in
            switch result {
            case .success(_):
                CartManager.shared.moviesInCart.removeAll()
                self.viewController?.showSuccessScreen()
                break
            case .failure(let error):
                if case let CheckoutError.OutOfStock(movieIds) = error {
                    CartManager.shared.updateOutOfStockMovies(movieIds: movieIds)
                    self.viewController?.showCartWithOutOfStockMovies(movieIds)
                    return
                }
                self.viewController?.showError(message: error.localizedDescription)
            }
        }
    }
    
}
