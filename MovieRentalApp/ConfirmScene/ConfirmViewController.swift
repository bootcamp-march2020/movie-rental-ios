//
//  ConfirmViewController.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 31/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDoneAction))
        
        setupViews()
        setupConstraints()
    }
    
    @objc private func handleDoneAction() {
        navigationController?.dismiss(animated: true)
    }
    
    private lazy var successLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 22, weight: .heavy)
        view.text = """
        Thanks for your order!
        We will send the order delivery in
        1 week. Check your mailbox for invoice!
        """
        view.textColor = .black
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "tick")
        view.contentMode = .scaleAspectFit
        view.setDimensions(width: 54, height: 54)
        return view
    }()
    
    private func setupViews() {
        view.addSubview(successLabel)
        view.addSubview(imageView)
    }
    
    private func setupConstraints() {
        successLabel.alignCenter(yPadding: -20)
        successLabel.fillSuperViewWidth(padding: 24)
        
        imageView.alignHorizontallyCenter()
        imageView.placeBelow(view: successLabel, padding: 15)
    }
    
}
