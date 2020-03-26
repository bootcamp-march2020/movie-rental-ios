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
    
    var cartPresenter: CartManagerProtocol!

    override func setUp() {
        cartPresenter = CartPresenter.init()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyMovieList() {
        XCTAssertEqual(cartPresenter.moviesInCart.count, 0)
    }

    func testAddMovie() {
        let movies = getDummyMovies(moviesCount: 2)
        for movie in movies {
            cartPresenter.addMovie(movie: movie)
        }
        XCTAssertEqual(cartPresenter.moviesInCart.count, 2)
    }
    
    func testRemoveMovie() {
        let movies = getDummyMovies(moviesCount: 10)
        for movie in movies {
            cartPresenter.addMovie(movie: movie)
        }
        cartPresenter.removeMovie(movie: movies.last!)
        XCTAssertEqual(cartPresenter.moviesInCart.count, 9)
    }
    
    private func getDummyMovies(moviesCount: Int) -> [MovieModel] {
        var movies: [MovieModel] = []
        for i in 0..<moviesCount {
            movies.append(MovieModel.init(id: "\(i)", name: "sf", posterUrlString: "sf", ratings: "6.7"))
        }
        return movies
    }

}

