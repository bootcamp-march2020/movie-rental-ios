//
//  HomeInteractorTests.swift
//  MovieRentalAppTests
//
//  Created by Sarath Chenthamarai on 31/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp

let responseError = ResponseError.UnknownResponseFormat

class HomeInteractorTests: XCTestCase {
    
    var homeInteractor: HomeInteractorProtocol!
    
    override func setUp() {
        super.setUp()
    }
    
    func testGetMovieList() {
        homeInteractor = HomeInteractor.init(apiManager: ApiManagerMock.init(), jsonManager: JSONManager.shared)
        let apiFetchExpectation = expectation(description: "Async block executed")
        var movieList: [MovieModel] = []
        homeInteractor.getMovieList { (result) in
            switch result {
            case let .success(movies):
                movieList = movies
            default:
                print("Error")
            }
            apiFetchExpectation.fulfill()
        }
        wait(for: [apiFetchExpectation], timeout: 1)
        XCTAssertEqual(movieList.first!.id, 7)
    }
    
    func testGetMovieListFailCase() {
        homeInteractor = HomeInteractor.init(apiManager: ApiManagerFailureMock.init(), jsonManager: JSONManager.shared)
        let apiFetchExpectation = expectation(description: "Async block executed")
        var responseErr: Error!
        homeInteractor.getMovieList { (result) in
            switch result {
            case let .failure(error):
                responseErr = error
                apiFetchExpectation.fulfill()
            default:
                print("Error")
            }
        }
        wait(for: [apiFetchExpectation], timeout: 1)
        XCTAssertEqual(String(describing: responseError), String(describing: responseErr!))
    }
    
}

class ApiManagerMock: APIManager {
    
    override func getMoviesList(completion: @escaping APIManager.ServerResponseCompletionHandler) {
        let movieJSON: [String : Any] = ["mid":7,
             "title":"Dil Se..",
        "posterUrlString":"https://m.media-amazon.com/images/M/MV5BMThjOGRjNmMtNjBmZi00MDJlLWE1YWUtZDY2YmU3YWMyYjlmXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg",
             "ratings":7.6,
             "type":"Movie",
             "pricingCategory":[
                "id":2,
                "name":"Clasic",
                "initialCostString":"$10 for 7 days",
                "additionalCostString":"and $2 afterwards"
             ]]
        completion(.success([movieJSON]))
    }
    
}

class ApiManagerFailureMock: APIManager {
    
    override func getMoviesList(completion: @escaping APIManager.ServerResponseCompletionHandler) {
        completion(.failure(responseError))
    }
    
}
