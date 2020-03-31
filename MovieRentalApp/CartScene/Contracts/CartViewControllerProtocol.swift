//
//  CartViewControllerProtocol.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol CartViewControllerProtocol: ClassProtocol {
    func showLoading(_ loading: Bool)
    func showOutOfStockAlert()
    func showError(_ error: Error)
    func showCheckout(for checkoutMovieModel: CheckoutMoviesSceneModel)
}
