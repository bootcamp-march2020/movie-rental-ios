//
//  LoginViewController.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    //MARK: Views and Constraints
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "MOVIE\nRENTAL"
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 64, weight: .heavy)
        return view
    }()
    
    private lazy var signinButton: GIDSignInButton = {
        let view = GIDSignInButton()
        view.style = .wide
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(signinButton)
    }
    
    private func setupConstraints() {
        titleLabel.alignCenter()
        
        signinButton.alignHorizontallyCenter()
        signinButton.placeBelow(view: titleLabel, padding: 120)
    }
    
}


extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        RootRouter.shared.setRootViewController(animated: true)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Login failed : \n ", error ?? "nil")
        let alert = UIAlertController(
            title: "Login failed!",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        present(alert, animated: true)
    }
    
}
