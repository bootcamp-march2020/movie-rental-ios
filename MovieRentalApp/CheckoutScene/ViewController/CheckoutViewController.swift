//
//  CheckoutViewController.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    private let cellId = "CheckoutMovieCell"
    
    private var checkOutMovies: [CheckoutMovie] = []
    
    init?(checkoutItems: [CheckoutMovie]) {
        if checkoutItems.isEmpty { return nil }
        self.checkOutMovies = checkoutItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var listView: UITableView = {
        let tableView = UITableView.init()
        tableView.isScrollEnabled = true
        tableView.rowHeight = 125
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartItemCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel.init()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.sizeToFit()
        totalLabel.setContentHuggingPriority(UILayoutPriority.init(999), for: NSLayoutConstraint.Axis.horizontal)
        return totalLabel
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let totalLabel = UILabel.init()
        totalLabel.sizeToFit()
        totalLabel.setContentHuggingPriority(UILayoutPriority.init(999), for: NSLayoutConstraint.Axis.horizontal)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalLabel
    }()
    
    private lazy var confirmButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setConstantHeight(38)
        view.setConstantWidth(120)
        view.backgroundColor = .systemBlue
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Confirm", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        view.layer.cornerRadius = 19
        view.layer.masksToBounds = true
        view.titleEdgeInsets = .init(top: 12, left: 20, bottom: 12, right: 20)
        return view
    }()
    
    private lazy var addressView: AddressComponentView = {
        let addressView = AddressComponentView.init()
        addressView.placeHolderLabel.text = "Address"
        addressView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        addressView.translatesAutoresizingMaskIntoConstraints = false
        return addressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.backgroundColor = .white
        title = "Checkout"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.setUpView()
        self.setViewConstraints()
        self.listView.reloadData()
    }
    
    private func setUpView() {
        self.view.addSubview(listView)
        self.view.addSubview(addressView)
        self.view.addSubview(totalLabel)
        self.view.addSubview(totalPriceLabel)
        self.view.addSubview(confirmButton)
    }
    
    private func setViewConstraints() {
        self.listView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.listView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        self.listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.addressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        self.addressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        self.addressView.topAnchor.constraint(equalTo: self.listView.bottomAnchor, constant: 10).isActive = true
        self.addressView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.addressView.bottomAnchor.constraint(equalTo: self.totalLabel.topAnchor, constant: -25).isActive = true
        self.confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        self.totalPriceLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.totalPriceLabel.bottomAnchor.constraint(equalTo: self.confirmButton.topAnchor, constant: -10).isActive = true
        self.totalPriceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.totalLabel.trailingAnchor.constraint(equalTo: self.totalPriceLabel.leadingAnchor, constant: -20).isActive = true
        self.totalLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.totalLabel.bottomAnchor.constraint(equalTo: self.totalPriceLabel.bottomAnchor).isActive = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    
}
 

extension CheckoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkOutMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CartItemCell {
            cell.setMovieInCheckOut(checkOutMovieModel: checkOutMovies[indexPath.item])
            return cell
        }
        return UITableViewCell()
    }

}
