//
//  CartViewControllerTests.swift
//  MovieRentalAppTests
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp

class CartViewControllerTests: XCTestCase {
    
    var cartManager: CartManager!
    
    override func setUp() {
        super.setUp()
        cartManager = CartManager()
    }
    
    func testCartViewControllerForEmptyMovies() {
        XCTAssertTrue(cartManager.moviesInCart.isEmpty)
        let controller = CartViewController(cartManager: cartManager)
        XCTAssertNil(controller)
    }
    
    func testCartViewController_RentalDict_ShouldNotBeEmpty() {
        cartManager.addMovie(movie: MovieModel.dummy)
        let controller = CartViewController(cartManager: cartManager)
        XCTAssertNotNil(controller)
        XCTAssertFalse(controller!.rentalDict.isEmpty)
    }
    
    func testCartViewController_RentalDict_ShouldEqualCountOfMovies() {
        MovieModel.dummies(number: 10).forEach { cartManager.addMovie(movie: $0) }
        let controller = CartViewController(cartManager: cartManager)
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller!.rentalDict.count, cartManager.moviesInCart.count)
    }
    
}
