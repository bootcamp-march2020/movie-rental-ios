//
//  UserProfileController.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        
        setupUserDetails()
    }
    
    private func setupUserDetails() {
        guard let profile = SessionManager.shared.currentUser.profile else { return }
        imageView.loadImage(with: profile.imageURL(withDimension: 150))
        nameLabel.text = profile.name
        emailLabel.text = profile.email
    }
    
    @objc private func handleSignOut() {
        SessionManager.shared.handleSignOut()
    }
    
    private lazy var imageView: AsyncImageView = {
        let view = AsyncImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setDimensions(width: 150, height: 150)
        view.backgroundColor = UIColor(white: 0.94, alpha: 1)
        view.layer.cornerRadius = 75
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17)
        view.textAlignment = .center
        view.textColor = .darkGray
        return view
    }()
    
    private lazy var signOutButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Sign Out", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        view.setTitleColor(.systemRed, for: .normal)
        view.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        return view
    }()
    
    private func setupViews() {
        [imageView, nameLabel, emailLabel, signOutButton].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        imageView.alignHorizontallyCenter()
        imageView.alignVerticallyCenter(padding: -150)
        
        nameLabel.fillSuperViewWidth(padding: 20)
        nameLabel.placeBelow(view: imageView, padding: 35)
        
        emailLabel.fillSuperViewWidth(padding: 20)
        emailLabel.placeBelow(view: nameLabel, padding: 12)
        
        signOutButton.alignHorizontallyCenter()
        signOutButton.placeBelow(view: emailLabel, padding: 70)
    }
    
}
