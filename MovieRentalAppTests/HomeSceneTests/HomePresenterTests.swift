//
//  HomePresenterTests.swift
//  MovieRentalAppTests
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp



class HomePresenterTests: XCTestCase {
    
    let presenter = HomePresenter()
    let homeViewController = HomeViewController()
    
    override func setUp() {
        super.setUp()
        homeViewController.presenter = presenter
        presenter.viewController = homeViewController
        presenter.interactor = HomeInteractorMock()
    }
    
    func testManageViewLoader() {
        presenter.manageViewLoaded()
    }
    
}


class HomeInteractorMock: HomeInteractorProtocol {
    func getMovieList(completion: @escaping (Result<[MovieModel], Error>) -> ()) {
        completion(.success(MovieModel.dummies(number: 1)))
    }
}
