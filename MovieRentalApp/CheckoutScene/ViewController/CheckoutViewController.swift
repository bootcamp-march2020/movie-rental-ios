//
//  CheckoutViewController.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UITextViewDelegate, CheckoutViewControllerProtocol {
    
    private let cellId = "CheckoutMovieCell"
    lazy var presenter: CheckoutPresenter = CheckoutPresenter()
    private var checkOutMovies: [CheckoutMovie] = []
    
    init?(checkoutSceneModel: CheckoutMoviesSceneModel) {
        if checkoutSceneModel.moviesList.isEmpty { return nil }
        self.checkOutMovies = checkoutSceneModel.moviesList
        
        super.init(nibName: nil, bundle: nil)
        self.totalPriceLabel.text = "$ \(checkoutSceneModel.totalCost)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        return inputBarComponent
    }
    
    private lazy var listView: UITableView = {
        let tableView = UITableView.init()
        tableView.isScrollEnabled = true
        tableView.contentInset.bottom = 250
        tableView.allowsSelection = false
        tableView.rowHeight = 125
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        tableView.register(CartItemCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel.init()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.sizeToFit()
        totalLabel.text = "Total"
        totalLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        totalLabel.setContentHuggingPriority(UILayoutPriority.init(999), for: NSLayoutConstraint.Axis.horizontal)
        return totalLabel
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let totalLabel = UILabel.init()
        totalLabel.sizeToFit()
        totalLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        totalLabel.setContentHuggingPriority(UILayoutPriority.init(999), for: NSLayoutConstraint.Axis.horizontal)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalLabel
    }()
    
    private lazy var confirmButton: ActionButton = {
        let view = ActionButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setConstantHeight(38)
        view.setConstantWidth(110)
        view.setTitle("Confirm", for: .normal)
        view.addTarget(self, action: #selector(handleConfirmAction), for: .touchUpInside)
        return view
    }()
    
    private lazy var addressView: AddressComponentView = {
        let addressView = AddressComponentView.init()
        addressView.textView.delegate = self
        addressView.placeHolderLabel.text = "Address"
        addressView.backgroundColor = UIColor.init(white: 0.92, alpha: 1)
        addressView.layer.cornerRadius = 8
        addressView.translatesAutoresizingMaskIntoConstraints = false
        return addressView
    }()
    
    private lazy var inputBarComponent: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 250))
        view.backgroundColor = .white
        [addressView, confirmButton, totalLabel, totalPriceLabel].forEach { view.addSubview($0) }
        addressView.anchorTop()
        addressView.fillSuperViewWidth(padding: 10, safeLayout: false)
        
        totalPriceLabel.anchorTrailing(padding: -10)
        totalPriceLabel.placeBelow(view: addressView, padding: 10)
        
        totalLabel.placeBeforeTo(view: totalPriceLabel, padding: -10)
        totalLabel.alignVerticallyCenter(with: totalPriceLabel)
        
        confirmButton.anchorBottom(padding: -20)
        confirmButton.anchorTrailing(padding: -10)
        confirmButton.placeBelow(view: totalPriceLabel, padding: 10)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Checkout"
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter.viewController = self
        self.setUpView()
        self.setViewConstraints()
        self.listView.reloadData()
        updateConfirmButton()
    }
    
    private func setUpView() {
        self.view.addSubview(listView)
    }
    
    private func setViewConstraints() {
        self.listView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.listView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        self.listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    fileprivate func updateConfirmButton() {
        confirmButton.isEnabled = !addressView.textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateConfirmButton()
    }
    
    @objc private func handleConfirmAction() {
        presenter.placeOrder(movies: checkOutMovies, address: addressView.textView.text ?? "")
    }
    
    func showSuccessScreen() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(ConfirmViewController(), animated: true)
        }
    }
    
    func showCartWithOutOfStockMovies(_ movieIds: [Int]) {
        showSimpleAlert(with: "Oops!", message: "Cart has some Out of Stock items. Please edit cart to continue.") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showLoading(_ loading: Bool) {
        loading ? confirmButton.showLoading() : confirmButton.stopLoading()
    }
    
    func showError(message: String) {
        showSimpleAlert(with: "Oops!", message: message)
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
