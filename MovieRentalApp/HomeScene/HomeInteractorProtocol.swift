//
//  HomeInteractorProtocol.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol {
    func getMovieList(completion: @escaping (Result<[MovieModel], Error>)->())
}
