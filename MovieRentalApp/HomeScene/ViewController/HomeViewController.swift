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
    lazy var cartManager: CartManagerProtocol = CartManager.shared
    
    private let kCellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        view.backgroundColor = .white
        
        if let controller = navigationController as? NavigationController {
            controller.setupNavigationItems(for: navigationItem)
            cartManager.valueUpdater = controller.cartImageView
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleCartItemDidChangeNotification(_:)), name: CartItemDidChangeNotification, object: nil)
        
        setupViews()
        setupConstraints()
        (presenter as? HomePresenter)?.viewController = self
        presenter.manageViewLoaded()
    }
    
    //MARK: ViewController Protocol Methods
    private (set) var movies: [MovieModel] = []
    
    func populateMovies(_ movies: [MovieModel]) {
        self.movies = movies
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
    }
    
    func showError(_ error: Error) {
        collectionView.isHidden = true
        placeholderLabel.text = String(describing: error)
    }
    
    //MARK: Actions
    @objc func handleCartItemDidChangeNotification(_ notification: Notification) {
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    //MARK: Views and Constraints
    private (set) lazy var placeholderLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = .red
        view.textAlignment = .center
        return view
    }()
    
    private (set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.register(MovieCell.self, forCellWithReuseIdentifier: kCellId)
        view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return view
    }()
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(placeholderLabel)
    }
    
    @objc func openCart() {
        
    }
    
    private func setupConstraints() {
        placeholderLabel.fillSuperViewWidth(padding: 24)
        placeholderLabel.alignCenter()
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! MovieCell
        cell.updateCell(movie: movies[indexPath.row], cartManager: self.cartManager)
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset
        let contentWidth = collectionView.bounds.width - (insets.left + insets.right)
        let width = (contentWidth / 2) - 5
        return CGSize.init(width: width, height: width * 1.65)
    }
    
}
