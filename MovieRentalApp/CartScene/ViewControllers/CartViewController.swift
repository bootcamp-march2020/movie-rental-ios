//
//  CartViewController.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, CartViewControllerProtocol {

    private let kCellId = "itemsCell"
    private let cartManager: CartManagerProtocol
    
    lazy var presenter: CartPresenterProtocol = {
        let presenter = CartPresenter()
        presenter.viewController = self
        return presenter
    }()
    
    private (set) var rentalDict: [Int: Int] = [:]
    
    var moviesInCart: [MovieModel] {
        return cartManager.moviesInCart
    }
    
    init?(cartManager: CartManagerProtocol) {
        self.cartManager = cartManager
        super.init(nibName: nil, bundle: nil)
        if moviesInCart.isEmpty { return nil }
        moviesInCart.forEach { rentalDict[$0.id] = CONFIG.DEFAULT_RENTAL_DAYS }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancelAction))
        
        setupViews()
        setupConstraints()
    }
    
    func showLoading(_ loading: Bool) {
        loading ? checkOutButton.showLoading() : checkOutButton.stopLoading()
    }
    
    func showCheckout(for checkoutMovieModel: CheckoutMoviesSceneModel) {
        guard let controller = CheckoutViewController.init(checkoutSceneModel: checkoutMovieModel) else {
            let alert = UIAlertController(title: "Invalid Checkout!", message: "No checkout items to proceed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: Actions
    @objc private func handleCancelAction() {
        dismiss(animated: true)
    }
    
    @objc private func handleCheckoutAction() {
        presenter.handleCartCheckout(for: moviesInCart, rentalDict: rentalDict)
    }
    
    //MARK: Views and Constraints
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CartItemCell.self, forCellReuseIdentifier: kCellId)
        view.rowHeight = 150
        view.dataSource = self
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        footerView.addSubview(checkOutButton)
        checkOutButton.alignCenter()
        view.tableFooterView = footerView
        view.allowsSelection = false
        view.delegate = self
        return view
    }()
    
    private lazy var checkOutButton: ActionButton = {
        let view = ActionButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setConstantHeight(38)
        view.setConstantWidth(120)
        view.setTitle("Checkout", for: .normal)
        view.addTarget(self, action: #selector(handleCheckoutAction), for: .touchUpInside)
        return view
    }()
    
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.fillSuperView()
    }

}


extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! CartItemCell
        let movie = moviesInCart[indexPath.row]
        cell.setMovie(movie,
                      rent: rentalDict[movie.id] ?? CONFIG.DEFAULT_RENTAL_DAYS,
                      rentUpdater: { [weak self] rent in self?.rentalDict[movie.id] = rent })
        return cell
    }
    
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartManager.removeMovie(movie: moviesInCart[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if moviesInCart.isEmpty {
                dismiss(animated: true)
            }
        }
    }
    
}
