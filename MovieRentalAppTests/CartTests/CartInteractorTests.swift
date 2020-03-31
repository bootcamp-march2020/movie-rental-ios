//
//  CartInteractorTests.swift
//  MovieRentalAppTests
//
//  Created by Sarath Chenthamarai on 31/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp

class CartInteractorTests: XCTestCase {
    
    var cartInteractor: CartInteractorProtocol!
    
    override func setUp() {
        super.setUp()
    }
    
    func testCheckoutItems() {
        cartInteractor = CartInteractor.init(apiManager: ApiManagerCheckoutMock.init(), jsonManager: JSONManager.shared)
        let apiFetchExpectation = expectation(description: "Async block executed")
        var movieModel: CheckoutMoviesSceneModel!
        cartInteractor.checkoutItems(movies: MovieModel.dummies(number: 1), rentalDict: [1: 6]) { (result) in
            switch result {
            case let .success(model):
                movieModel = model
            default:
                print("")
            }
            apiFetchExpectation.fulfill()
        }
        wait(for: [apiFetchExpectation], timeout: 1)
        XCTAssertEqual(movieModel!.totalCost, 4)
    }
    
    func testOutOfStockMovies() {
        cartInteractor = CartInteractor.init(apiManager: ApiManagerOutOfStockMock.init(), jsonManager: JSONManager.shared)
        let apiFetchExpectation = expectation(description: "Async block executed")
        var err: Error!
        cartInteractor.checkoutItems(movies: MovieModel.dummies(number: 1), rentalDict: [1: 6]) { (result) in
            switch result {
            case .success(_):
                print("")
            case let .failure(error):
                err = error
            }
            apiFetchExpectation.fulfill()
        }
        wait(for: [apiFetchExpectation], timeout: 1)
        XCTAssertEqual(String(describing: err!), String(describing: CheckoutError.OutOfStock(movieIds: [1])))
    }
    
}


class ApiManagerCheckoutMock: APIManager {
    override func checkoutItems(bodyData: Data, completion: @escaping APIManager.ServerResponseCompletionHandler) {
        let checkoutResponse: [String: Any] = ["cartItemList":[["movie":["id":1,"title":"Avatar"],"numberOfDays":7,"cost":4.0,"priceCategoryName":"Default","initialCostString":"$2 for 5 days","additionalCostString":"and $1 afterwards"]],"totalCost":4.0,"outOfStockMoviesIds":[]]
        completion(.success(checkoutResponse))
    }
}

class ApiManagerOutOfStockMock: APIManager {
    override func checkoutItems(bodyData: Data, completion: @escaping APIManager.ServerResponseCompletionHandler) {
        completion(.failure(CheckoutError.OutOfStock(movieIds: [1])))
    }
}
