//
//  CartInteractorProtocol.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol CartInteractorProtocol: ClassProtocol {
    func checkoutItems(rentalDict: [Int: Int], completion: @escaping (Result<CheckoutMoviesSceneModel, Error>)->())
}
