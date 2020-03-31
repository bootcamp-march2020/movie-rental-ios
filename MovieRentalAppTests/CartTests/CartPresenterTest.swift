//
//  CartPresenterTest.swift
//  MovieRentalAppTests
//
//  Created by Sarath Chenthamarai on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp

class CartPresenterTest: XCTestCase {
    
    var cartManager: CartManagerProtocol!
    var cartIconView: HomeCartIconView!
    override func setUp() {
        cartManager = CartManager()
        cartIconView = HomeCartIconView()
        cartManager.valueUpdater = cartIconView
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyMovieList() {
        XCTAssertEqual(cartManager.moviesInCart.count, 0)
    }

    func testAddMovie() {
        let movies = MovieModel.dummies(number: 2)
        let asyncExpectation = expectation(description: "Async block executed")
        
        movies.forEach { cartManager.addMovie(movie: $0) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { asyncExpectation.fulfill() }
        waitForExpectations(timeout: 1)
        
        XCTAssertFalse(cartIconView.badgeLabel.isHidden)
        XCTAssertEqual(cartIconView.badgeLabel.text, " 2 ")
        XCTAssertEqual(cartManager.moviesInCart.count, 2)
    }
    
    func testRemoveMovie() {
        let movies = MovieModel.dummies(number: 10)
        let asyncExpectation = expectation(description: "Async block executed")
        
        movies.forEach { cartManager.addMovie(movie: $0) }
        cartManager.removeMovie(movie: movies.last!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { asyncExpectation.fulfill() }
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(cartIconView.badgeLabel.text, " 9 ")
        XCTAssertEqual(cartManager.moviesInCart.count, 9)
    }

}

