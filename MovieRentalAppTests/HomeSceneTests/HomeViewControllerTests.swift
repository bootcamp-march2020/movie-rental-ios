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
        XCTAssertFalse(viewController.movies.isEmpty, "Cannot be empty after population")
    }
    
    func testPopulateMoviesShouldCallReloadData() {
        let movies: [MovieModel] = MovieModel.dummies(number: 30)
        viewController.populateMovies(movies)
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), movies.count)
    }
    
    func testPopulateMoviesShouldUpdateVisibility() {
        viewController.collectionView.isHidden = true
        let movies: [MovieModel] = MovieModel.dummies(number: 30)
        viewController.populateMovies(movies)
        XCTAssertFalse(viewController.collectionView.isHidden)
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
    
    static let dummy: MovieModel = MovieModel.init(id: 1, name: "sf", posterUrlString: "url", ratings: "7.8")
    static func dummies(number: Int) -> [MovieModel] {
        var movies: [MovieModel] = []
        for i in 0..<number {
            movies.append(MovieModel.init(id: i, name: "sf", posterUrlString: "sf", ratings: "6.7"))
        }
        return movies
    }
    
}
