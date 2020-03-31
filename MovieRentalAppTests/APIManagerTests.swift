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
        let invalidUrlString = ""
        let asyncExpectation = expectation(description: "Async block executed")
        
        apiManager.makeServerCall(invalidUrlString) { result in
            switch result {
            case .success(_):
                assertionFailure("Shouldn't return success")
                
            case let .failure(error):
                switch error {
                case NetworkError.InvalidURL: XCTAssertTrue(true)
                default: XCTAssertFalse(true, "Should only throw InvalidURL. Thrown error \(error)")
                }
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testMakeServerCallWithInvalidUserSession() {
        apiManager.sessionManager = InvalidSessionManager()
        let asyncExpectation = expectation(description: "Async block executed")
        
        apiManager.makeServerCall("https://www.google.com/") { result in
            switch result {
            case .success(_):
                assertionFailure("Shouldn't return success")
                
            case let .failure(error):
                switch error {
                case NetworkError.InvalidUser: XCTAssertTrue(true)
                default: XCTAssertFalse(true, "Should only throw InvalidUser. Thrown error \(error)")
                }
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetServerURLRequestWithDummySession() {
        apiManager.sessionManager = DummySessionManager()
        let url = URL(string: "https://www.google.com/")!
        let method: HTTPMethod = .POST
        
        guard let request = try? apiManager.getServerURLRequest(for: url, method: method) else {
            assertionFailure("Shouldn't be nil")
            return
        }
        
        XCTAssertEqual(request.httpMethod, method.rawValue)
        let setToken = request.allHTTPHeaderFields?["id-token"]
        XCTAssertNotNil(setToken)
        XCTAssertEqual(setToken, apiManager.sessionManager.getAccessToken())
    }
    
    func testManageServerResponseWithValidData() {
        let validString = #"{"statusCode":200,"message":"Success","payload": { }}"#
        guard let validData = validString.data(using: .utf8) else {
            assertionFailure("data conversion error")
            return
        }
        let validated = try? apiManager.manageServerResponse(data: validData)
        XCTAssertNotNil(validated)
    }
    
    func testManageServerResponseWithInValidData() {
        let string = #"{ }"#
        guard let data = string.data(using: .utf8) else {
            assertionFailure("data conversion error")
            return
        }
        XCTAssertThrowsError(try apiManager.manageServerResponse(data: data)) { error in
            switch error {
            case ResponseError.UnknownResponseFormat: XCTAssertTrue(true)
            default: XCTAssertTrue(false)
            }
        }
    }
    
    func testManageServerResponseWithInvalidRequestResponseData() {
        let string = #"{"statusCode":401,"message":"no authorisation token is present","payload":""}"#
        guard let data = string.data(using: .utf8) else {
            assertionFailure("data conversion error")
            return
        }
        XCTAssertThrowsError(try apiManager.manageServerResponse(data: data)) { error in
            switch error {
            case ResponseError.UnauthorizedRequest: XCTAssertTrue(true)
            default: XCTAssertTrue(false)
            }
        }
    }
    
}

class InvalidSessionManager: SessionManagerProtocol {
    var isUserSignedIn: Bool {
        return false
    }
    
    func getAccessToken() -> String? {
        return nil
    }
}

class DummySessionManager: SessionManagerProtocol {
    var isUserSignedIn: Bool {
        return true
    }
    
    func getAccessToken() -> String? {
        return "access-token"
    }
}
