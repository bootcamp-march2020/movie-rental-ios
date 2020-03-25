//
//  HomeViewControllerTests.swift
//  MovieRentalAppTests
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp

class HomeViewControllerTests: XCTestCase {
    
    var viewController: HomeViewController!
    
    override func setUp() {
        super.setUp()
        viewController = HomeViewController()
    }
    
    func testMoviesInitiallyEmpty() {
        XCTAssertTrue(viewController.movies.isEmpty)
    }
    
    func testPopulateMovies() {
        let movies: [MovieModel] = MovieModel.dummies(number: 30)
        viewController.populateMovies(movies)
        XCTAssertFalse(viewController.movies.isEmpty)
    }
    
    func testPopulateMoviesShouldCallReloadData() {
        let movies: [MovieModel] = MovieModel.dummies(number: 30)
        viewController.populateMovies(movies)
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), movies.count)
    }
    
    func testPopulateMoviesForEmptyCase() {
        
    }
    
    func testShowError() {
        
    }
    
}



class MockHomePresenter: HomePresenterProtocol {
    
    func manageViewLoaded() {
        
    }
    
}


extension MovieModel {
    
    static let dummy: MovieModel = MovieModel(id: "sd", name: "sd", year: 123, rated: "sd", posterUrlString: "sd", releaseDate: Date(), genre: ["", ""], director: "sdf", actors: ["", ""], languages: ["", ""], ratings: "sf", type: "sd", price: 56.5)
    
    static func dummies(number: Int) -> [MovieModel] {
        return (0 ..< number).map { _ in .dummy }
    }
    
}
