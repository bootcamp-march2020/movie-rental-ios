//
//  HomePresenterTests.swift
//  MovieRentalAppTests
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp

fileprivate let kDummiesCount = 3
fileprivate let kGeneralError = ResponseError.UnknownResponseFormat

class HomePresenterTests: XCTestCase {
    
    let presenter = HomePresenter()
    let homeViewController = HomeViewController()
    
    override func setUp() {
        super.setUp()
        homeViewController.presenter = presenter
        presenter.viewController = homeViewController
        presenter.interactor = HomeInteractorMock()
    }
    
    func testGetMoviesList_ShouldLoadMovies() {
        let asyncExpectation = expectation(description: "async expectation")
        
        presenter.getMoviesList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { asyncExpectation.fulfill() }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(kDummiesCount, homeViewController.movies.count)
    }
    
    func testGetMoviesList_ShouldShowError() {
        presenter.interactor = FailingHomeInteractor()
        let asyncExpectation = expectation(description: "async expectation")
        
        presenter.getMoviesList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { asyncExpectation.fulfill() }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertFalse(homeViewController.errorLabel.isHidden)
        XCTAssertTrue(homeViewController.collectionView.isHidden)
        XCTAssertEqual(String(describing: kGeneralError), homeViewController.errorLabel.text)
    }
    
}


class HomeInteractorMock: HomeInteractorProtocol {
    func getMovieList(completion: @escaping (Result<[MovieModel], Error>) -> ()) {
        completion(.success(MovieModel.dummies(number: kDummiesCount)))
    }
}

class FailingHomeInteractor: HomeInteractorProtocol {
    func getMovieList(completion: @escaping (Result<[MovieModel], Error>) -> ()) {
        completion(.failure(kGeneralError))
    }
}
