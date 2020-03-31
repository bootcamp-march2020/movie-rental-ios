//
//  APIManager.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case InvalidURL, InvalidUser, DataIsNil
}

enum ResponseError: Error {
    case UnknownResponseFormat, UnauthorizedAccess, UnauthorizedRequest, Custom(message: String)
    
    init(code: Int, message: String) {
        switch code {
        case 406: self = .UnauthorizedAccess
        case 401: self = .UnauthorizedRequest
        default: self = .Custom(message: message)
        }
    }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

class APIManager {
    
    static let shared = APIManager()
    
    typealias ServerResponseResult = Result<Any, Error>
    typealias ServerResponseCompletionHandler = (ServerResponseResult)->()
    var sessionManager: SessionUtilsProtocol.Type = SessionUtils.self
    
    func makeAPICall(with request: URLRequest, completion: @escaping (Result<Data, Error>)->()) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.DataIsNil))
                return
            }
            
            print("RES - ", String.init(data: data, encoding: .utf8) ?? "nil")
            completion(.success(data))
        }.resume()
    }
    
    func makeServerCall(_ url: String, method: HTTPMethod = .GET, body: Data? = nil, completion: @escaping ServerResponseCompletionHandler) {
        
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.InvalidURL))
            return
        }
        
        do {
            let request = try getServerURLRequest(for: url, method: method, bodyData: body)
            makeAPICall(with: request) { result in
                switch result {
                case let .success(data):
                    let result = Result { try self.manageServerResponse(data: data) }
                    completion(result)
                    
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
    }
    
    func manageServerResponse(data: Data) throws -> Any {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        guard let jsonObj = json as? [String: Any],
            let code = jsonObj["statusCode"] as? Int,
            let message = jsonObj["message"] as? String
        else { throw ResponseError.UnknownResponseFormat }
        
        guard (code >= 200 && code < 300) else { throw ResponseError(code: code, message: message) }
        
        guard let payload = jsonObj["payload"] else { throw ResponseError.UnknownResponseFormat }
        
        return payload
    }
    
    func getServerURLRequest(for url: URL, method: HTTPMethod, bodyData: Data? = nil) throws -> URLRequest {
        guard let idToken = sessionManager.getAccessToken() else { throw NetworkError.InvalidUser }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if method == .POST {
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.httpBody = bodyData
        }
        request.addValue(idToken, forHTTPHeaderField: "id-token")
        return request
    }
    
    func getMoviesList(completion: @escaping ServerResponseCompletionHandler) {
        let movieUrl = CONFIG.BASE_URL + "/movies"
        makeServerCall(movieUrl, completion: completion)
    }
    
    func checkoutItems(bodyData: Data, completion: @escaping ServerResponseCompletionHandler) {
        let checkoutUrl = CONFIG.BASE_URL + "/checkout"
        makeServerCall(checkoutUrl, method: .POST, body: bodyData, completion: completion)
    }
    
    func placeOrder(bodyData: Data, completion: @escaping ServerResponseCompletionHandler) {
        let checkoutUrl = CONFIG.BASE_URL + "/placeorder"
        makeServerCall(checkoutUrl, method: .POST, body: bodyData, completion: completion)
    }
}
