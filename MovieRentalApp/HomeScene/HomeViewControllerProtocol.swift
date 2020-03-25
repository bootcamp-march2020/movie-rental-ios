//
//  HomeViewControllerProtocol.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

protocol HomeViewControllerProtocol: ClassProtocol {
    var movies: [MovieModel] { get }
    func populateMovies(_ movies: [MovieModel])
    func showError(_ error: Error)
}




protocol ClassProtocol: class { }
