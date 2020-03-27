//
//  CartViewController.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    private (set) public var movies: [MovieModel] = []
    private let kCellId = "itemsCell"
    
    init?(movies: [MovieModel]) {
        if movies.isEmpty { return nil }
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
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
    
    //MARK: Actions
    @objc private func handleCancelAction() {
        dismiss(animated: true)
    }
    
    //MARK: Views and Constraints
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CartItemCell.self, forCellReuseIdentifier: kCellId)
        view.rowHeight = 124
        view.dataSource = self
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        footerView.addSubview(checkOutButton)
        checkOutButton.alignCenter()
        view.tableFooterView = footerView
        return view
    }()
    
    private lazy var checkOutButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setConstantHeight(38)
        view.setConstantWidth(120)
        view.backgroundColor = .systemBlue
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Checkout", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        view.layer.cornerRadius = 19
        view.layer.masksToBounds = true
        view.titleEdgeInsets = .init(top: 12, left: 20, bottom: 12, right: 20)
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
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! CartItemCell
        cell.setMovie(movies[indexPath.row])
        return cell
    }
    
}
