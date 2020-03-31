//
//  MovieCell.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    weak var cartManagerDelegate: CartManagerProtocol!
    private var movie: MovieModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(white: 0.96, alpha: 1)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        self.setUpView()
        self.setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(movie: MovieModel, cartManager: CartManagerProtocol) {
        self.movie = movie
        self.cartManagerDelegate = cartManager
        self.movieTitleLabel.text = movie.name
        self.ratingLabel.text = "Ratings: \(movie.ratings)"
        self.moviePoster.loadImageUsingURLString(movie.posterUrlString)
        self.categoryLabel.text = movie.pricing.name
        updateAddToCartButton()
    }
    
    lazy var moviePoster: AsyncImageView = {
        let imageView = AsyncImageView.init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage.init(named: "poster")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addToCartButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToCart), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.setContentHuggingPriority(UILayoutPriority.init(750), for: NSLayoutConstraint.Axis.horizontal)
        button.layer.cornerRadius = 5
        button.sizeToFit()
        return button
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    @objc func addToCart() {
        if self.movie != nil, (cartManagerDelegate?.moviesInCart.contains(self.movie)) == true {
            cartManagerDelegate.removeMovie(movie: movie)
        } else if movie != nil {
            cartManagerDelegate?.addMovie(movie: movie)
        }
        updateAddToCartButton()
    }
    
    func updateAddToCartButton() {

        if self.movie != nil, (cartManagerDelegate?.moviesInCart.contains(self.movie)) == true {
            let attrStr = NSMutableAttributedString.init(string: " Remove ")
            attrStr.addAttributes([NSAttributedString.Key.backgroundColor : UIColor.systemRed.withAlphaComponent(0.75), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)], range: NSRange.init(location: 0, length: attrStr.length))
            addToCartButton.setAttributedTitle(attrStr, for: UIControl.State.normal)
        } else {
            let attrStr = NSMutableAttributedString.init(string: " Add ")
            attrStr.addAttributes([NSAttributedString.Key.backgroundColor : UIColor.systemGreen.withAlphaComponent(0.6), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)], range: NSRange.init(location: 0, length: attrStr.length))
            addToCartButton.setAttributedTitle(attrStr, for: UIControl.State.normal)
        }
    }
    
    private func setUpView() {
        addSubview(moviePoster)
        addSubview(addToCartButton)
        addSubview(movieTitleLabel)
        addSubview(ratingLabel)
        addSubview(categoryLabel)
        updateAddToCartButton()
    }
    
    private func setUpContraints() {
        
        moviePoster.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        moviePoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        
        movieTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: self.moviePoster.bottomAnchor, constant: 5).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        categoryLabel.placeBelow(view: movieTitleLabel, padding: 3)
        categoryLabel.anchorLeading(padding: 10)
        
        ratingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 3).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        addToCartButton.leadingAnchor.constraint(equalTo: self.ratingLabel.trailingAnchor, constant: 10).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addToCartButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
          
    }
    
}
