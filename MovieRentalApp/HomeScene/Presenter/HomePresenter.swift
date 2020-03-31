//
//  HomePresenter.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    weak var viewController: HomeViewControllerProtocol?
    lazy var interactor: HomeInteractorProtocol = HomeInteractor()
    
    func getMoviesList() {
        interactor.getMovieList { (result) in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    self.viewController?.showError(error)
                    
                case let .success(data):
                    self.viewController?.populateMovies(data)
                }
            }
        }
    }
    
}
