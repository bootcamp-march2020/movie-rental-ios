//
//  CartPresenterProtocol.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol CartPresenterProtocol: ClassProtocol {
    func handleCartCheckout(for items: [MovieModel], rentalDict: [Int: Int])
}
