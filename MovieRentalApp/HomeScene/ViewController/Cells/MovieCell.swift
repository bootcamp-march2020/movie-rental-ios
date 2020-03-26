//
//  MovieCell.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      //  layer.cornerRadius = 10
        layer.masksToBounds = true
        
        self.setUpView()
        self.setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell(movie: MovieModel) {
        self.movieTitleLabel.text = movie.name
        self.ratingLabel.text = movie.ratings
        self.moviePoster.loadImageUsingURLString(movie.posterUrlString)
    }
    
    lazy var moviePoster: AsyncImageView = {
        let imageView = AsyncImageView.init()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.gray
        imageView.image = UIImage.init(named: "poster")
       // imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addToCartButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
        button.setTitle(" Remove ", for: UIControl.State.normal)
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
        label.text = "Harry Potter"
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating: 7.6/10"
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private func setUpView() {
        addSubview(moviePoster)
        addSubview(verticalStackView)
        addSubview(addToCartButton)
        verticalStackView.addArrangedSubview(movieTitleLabel)
        verticalStackView.addArrangedSubview(ratingLabel)
       // verticalStackView.addArrangedSubview(priceLabel)
    }
    
    private func setUpContraints() {
        
        moviePoster.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        moviePoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        moviePoster.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        addToCartButton.leadingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor, constant: 10).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addToCartButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.addToCartButton.leadingAnchor, constant: -10).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: self.moviePoster.bottomAnchor, constant: 10).isActive = true
        
//        movieTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//        movieTitleLabel.topAnchor.constraint(equalTo: self.moviePoster.bottomAnchor, constant: 10).isActive = true
//        movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
//        movieTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        ratingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//        ratingLabel.topAnchor.constraint(equalTo: self.movieTitleLabel.bottomAnchor, constant: 10).isActive = true
//        ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
//        ratingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
//        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        priceLabel.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 5).isActive = true
        
    }
    
}
