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
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        self.setUpView()
        self.setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell(movie: MovieModel) {
        self.movieTitleLabel.text = movie.name
        self.ratingLabel.text = movie.rated
        self.priceLabel.text = "\(movie.price)"
        self.moviePoster.loadImageUsingURLString(movie.posterUrlString)
    }
    
    lazy var moviePoster: AsyncImageView = {
        let imageView = AsyncImageView.init()
        imageView.backgroundColor = UIColor.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        label.text = "Demo"
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating"
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
        verticalStackView.addArrangedSubview(movieTitleLabel)
        verticalStackView.addArrangedSubview(ratingLabel)
        verticalStackView.addArrangedSubview(priceLabel)
    }
    
    private func setUpContraints() {
        
        moviePoster.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        moviePoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
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
