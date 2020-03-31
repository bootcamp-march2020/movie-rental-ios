//
//  CartItemCell.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    typealias RentUpdater = (Int)->()
    
    private var rentUpdater: RentUpdater?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMovie(_ movie: MovieModel, rent: Int, rentUpdater: RentUpdater?) {
        movieImageView.loadImageUsingURLString(movie.posterUrlString)
        movieTitleLabel.text = movie.name
        pricingTypeLabel.text = movie.pricing.name
        pricingLabel.text = movie.pricing.formattedPricing
        stepper.value = Double(rent)
        rentalValueLabel.text = "\(rent)"
        rentalDaysLabel.text = "Number of Days"
        self.manageOutOfStock(movie.isOutOfStock)
        self.rentUpdater = rentUpdater
    }
    
    func setMovieInCheckOut(checkOutMovieModel: CheckoutMovie) {
        stepper.isHidden = true
        rentalValueLabel.isHidden = false
        
        movieTitleLabel.text = checkOutMovieModel.movieName
        rentalDaysLabel.text = "Rented Days: \(checkOutMovieModel.numberOfDays)"
        rentalValueLabel.text = "$\(checkOutMovieModel.cost)"
        
        if let posterUrl = checkOutMovieModel.posterUrl,
            let pricingModel = checkOutMovieModel.pricingModel
        {
            movieImageView.loadImageUsingURLString(posterUrl)
            pricingTypeLabel.text = pricingModel.name
            pricingLabel.text = pricingModel.formattedPricing
        }
    }
    
    private func manageOutOfStock(_ value: Bool) {
        errorLabel.isHidden = !value
        stepper.isHidden = value
        rentalValueLabel.isHidden = value
        rentalDaysLabel.isHidden = value
    }
    
    @objc private func handleStepperValueChange() {
        let days = Int(stepper.value)
        rentalValueLabel.text = "\(days)"
        rentUpdater?(days)
    }
    
    private lazy var movieImageView: AsyncImageView = {
        let view = AsyncImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 0.94, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var pricingTypeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15)
        view.textColor = .darkGray
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var pricingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .right
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private lazy var rentalDaysLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.text = "Number of Days"
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15)
        view.textColor = .systemRed
        view.numberOfLines = 1
        view.adjustsFontSizeToFitWidth = true
        view.text = "Out of Stock"
        view.isHidden = true
        return view
    }()
    
    private lazy var stepper: UIStepper = {
        let view = UIStepper()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        view.minimumValue = Double(Config.MIN_RENTAL_DAYS)
        view.maximumValue = Double(Config.MAX_RENTAL_DAYS)
        view.value = Double(Config.DEFAULT_RENTAL_DAYS)
        view.addTarget(self, action: #selector(handleStepperValueChange), for: .valueChanged)
        return view
    }()
    
    private lazy var rentalValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17, weight: .bold)
        view.numberOfLines = 1
        view.textAlignment = .right
        return view
    }()
    
    private func setupViews() {
        [movieImageView, movieTitleLabel, pricingLabel, pricingTypeLabel, errorLabel, rentalDaysLabel, stepper, rentalValueLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        movieImageView.anchorLeading(padding: 12)
        movieImageView.anchorTop(padding: 12)
        movieImageView.setDimensions(width: 100, height: 100)
        
        movieTitleLabel.matchContraint(.top, ofView: movieImageView)
        movieTitleLabel.placeNextTo(view: movieImageView, padding: 12)
        movieTitleLabel.placeBeforeTo(view: pricingLabel, padding: -12)
        
        pricingTypeLabel.placeBelow(view: movieTitleLabel, padding: 5)
        pricingTypeLabel.matchContraint(.leading, ofView: movieTitleLabel)
        
        errorLabel.placeBelow(view: pricingTypeLabel, padding: 5)
        errorLabel.matchContraint(.leading, ofView: movieTitleLabel)
        
        pricingLabel.matchContraint(.top, ofView: movieTitleLabel)
        pricingLabel.anchorTrailing(padding: -12)
        pricingLabel.setConstantWidth(90)
        
        rentalDaysLabel.placeBelow(view: errorLabel, padding: 12)
        rentalDaysLabel.anchorBottom(padding: -24)
        rentalDaysLabel.matchContraint(.leading, ofView: movieTitleLabel)
        
        rentalValueLabel.matchContraint(.bottom, ofView: rentalDaysLabel)
        rentalValueLabel.anchorTrailing(padding: -12)
        rentalValueLabel.setConstantRestrictingWidth(30)
        
        stepper.leadingAnchor.constraint(greaterThanOrEqualTo: rentalDaysLabel.trailingAnchor).isActive = true
        stepper.placeBeforeTo(view: rentalValueLabel)
        stepper.alignVerticallyCenter(with: rentalValueLabel)
    }
    
}
