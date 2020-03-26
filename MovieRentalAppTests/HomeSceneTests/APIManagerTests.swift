//
//  APIManagerTests.swift
//  MovieRentalAppTests
//
//  Created by Akaash Dev on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import XCTest
@testable import MovieRentalApp

class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!
    
    override func setUp() {
        super.setUp()
        apiManager = APIManager.shared
    }
    
    func testMakeServerCallWithInvalidURL() {
        let invalidUrlString = "server"
        apiManager.makeServerCall(invalidUrlString) { result in
            switch result {
            case .success(_):
                assertionFailure("Shouldn't return success")
                
            case let .failure(error):
                switch error {
                case NetworkError.InvalidURL: XCTAssertTrue(true)
                default: XCTAssertFalse(true)
                }
            }
        }
    }
    
    func testMakeServerCallWithInvalidUserSession() {
        apiManager.sessionManager = InvalidSessionUtils.self
        apiManager.makeServerCall("https://www.google.com/") { result in
            switch result {
            case .success(_):
                assertionFailure("Shouldn't return success")
                
            case let .failure(error):
                switch error {
                case NetworkError.InvalidUser: XCTAssertTrue(true)
                default: XCTAssertFalse(true)
                }
            }
        }
    }
    
    func testGetServerURLRequestWithDummySession() {
        apiManager.sessionManager = DummySessionUtils.self
        let url = URL(string: "https://www.google.com/")!
        let method = "POST"
        
        guard let request = try? apiManager.getServerURLRequest(for: url, method: method) else {
            assertionFailure("Shouldn't be nil")
            return
        }
        
        XCTAssertEqual(request.httpMethod, method)
        let setToken = request.allHTTPHeaderFields?["id-token"]
        XCTAssertNotNil(setToken)
        XCTAssertEqual(setToken, apiManager.sessionManager.getAccessToken())
    }
    
}

class InvalidSessionUtils: SessionUtilsProtocol {
    static var isUserSignedIn: Bool {
        return false
    }
    
    static func getAccessToken() -> String? {
        return nil
    }
}

class DummySessionUtils: SessionUtilsProtocol {
    static var isUserSignedIn: Bool {
        return true
    }
    
    static func getAccessToken() -> String? {
        return "access-token"
    }
}
