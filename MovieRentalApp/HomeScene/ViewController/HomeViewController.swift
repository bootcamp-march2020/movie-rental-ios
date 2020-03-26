//
//  HomeViewController.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    lazy var presenter: HomePresenterProtocol = HomePresenter()
    
    private let kCellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        (presenter as? HomePresenter)?.viewController = self
        presenter.manageViewLoaded()
    }
    
    //MARK: ViewController Protocol Methods
    private (set) var movies: [MovieModel] = []
    
    func populateMovies(_ movies: [MovieModel]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.collectionView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        
    }
    
    //MARK: Views and Constraints
    private (set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.register(MovieCell.self, forCellWithReuseIdentifier: kCellId)
        return view
    }()
    
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
}


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! MovieCell
        cell.updateCell(movie: movies[indexPath.row])
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 2) - 5
        return CGSize.init(width: width, height: width * 1.5)
    }
    
}
