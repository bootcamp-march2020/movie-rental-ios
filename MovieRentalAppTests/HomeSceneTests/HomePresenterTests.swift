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
    
    var presenter: HomePresenterProtocol!
    
    override func setUp() {
        super.setUp()
        presenter = HomePresenter()
    }
    
    func testManageViewLoader() {
        presenter.manageViewLoaded()
        
    }
    
}
