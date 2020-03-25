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
    }
    
    //MARK: ViewController Protocol Methods
    private (set) var movies: [MovieModel] = []
    
    func populateMovies(_ movies: [MovieModel]) {
        self.movies = movies
        collectionView.reloadData()
    }
    
    func showError(_ error: Error) {
        
    }
    
    //MARK: Views and Constraints
    private (set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.backgroundColor = .white
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellId)
        return view
    }()
    
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
