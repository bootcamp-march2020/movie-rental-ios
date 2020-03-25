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
    
    public func manageViewLoaded() {
        
    }
    
    private func getMovieList() -> [MovieModel] {
        return []
    }
    
}
