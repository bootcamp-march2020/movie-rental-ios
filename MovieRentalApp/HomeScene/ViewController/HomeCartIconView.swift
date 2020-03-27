//
//  HomeCartIconView.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import Foundation
import UIKit

protocol CartValueUpdator: ClassProtocol {
    func showCartCount(_ count: Int)
}

class HomeCartIconView: UIView, CartValueUpdator {
    
    lazy var cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(named: "cart")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.systemBlue
        label.layer.cornerRadius = 6.5
        label.clipsToBounds = true
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.white
        label.setContentHuggingPriority(UILayoutPriority.init(999), for: NSLayoutConstraint.Axis.horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showCartCount(_ count: Int) {
        if count <= 0 {
            badgeLabel.isHidden = true
        } else {
            badgeLabel.isHidden = false
            badgeLabel.text = " \(count) "
        }
    }
    
    private func setUpView() {
        addSubview(cartImageView)
        addSubview(badgeLabel)
        showCartCount(0)
    }
    
    private func setUpConstraints() {
        cartImageView.alignCenter()
        cartImageView.fillSuperView()
        badgeLabel.trailingAnchor.constraint(equalTo: self.cartImageView.trailingAnchor).isActive = true
        badgeLabel.topAnchor.constraint(equalTo: self.cartImageView.topAnchor).isActive = true
    }
    
}
