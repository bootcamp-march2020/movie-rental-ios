//
//  RootRouter.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit
import GoogleSignIn

class RootRouter {
    
    static let shared = RootRouter()
    
    private (set) var window: UIWindow?
    
    func initialize(with window: UIWindow) {
        self.window = window
        setRootViewController(animated: false)
    }
    
    func setRootViewController(animated: Bool) {
        guard let window = window else { return }
        
        func setController() {
            window.rootViewController = SessionUtils.isUserSignedIn ? NavigationController(rootViewController: HomeViewController()) : LoginViewController()
        }
        
        if animated {
            UIView.transition(
                with: window,
                duration: 0.25,
                options: .transitionFlipFromLeft,
                animations: { setController() }
            )
        }
        else {
            setController()
        }
    }
    
}


class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
    }
    
    func setupNavigationItems(for item: UINavigationItem) {
        item.leftBarButtonItem = UIBarButtonItem(customView: userImageView)
        item.rightBarButtonItem = UIBarButtonItem(customView: cartImageView)
        userImageView.loadImage(with: SessionUtils.currentUser.profile.imageURL(withDimension: 32))
    }
    
    @objc private func handleViewProfileAction() {
        present(UserProfileController(), animated: true)
    }
    
    @objc private func handleViewCartAction() {
        let movies = CartManager.shared.moviesInCart
        guard let controller = CartViewController(movies: movies) else {
            let alert = UIAlertController(
                title: "Cart is Empty!",
                message: "Please add some items in the cart to proceed.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
            return
        }
        present(UINavigationController(rootViewController: controller), animated: true)
    }
    
    private func getImageView(with imageNamed: String, action: Selector, rounded: Bool = false) -> AsyncImageView {
        let view = AsyncImageView(image: UIImage(named: imageNamed))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setConstantWidth(32)
        view.setConstantHeight(32)
        if rounded {
            view.layer.cornerRadius = 16
            view.layer.masksToBounds = true
        }
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        return view
    }
    
    private func getCartView() -> HomeCartIconView {
        let cartIconView = HomeCartIconView.init()
        cartIconView.translatesAutoresizingMaskIntoConstraints = false
        cartIconView.setConstantWidth(32)
        cartIconView.setConstantHeight(32)
        cartIconView.contentMode = .scaleAspectFit
        cartIconView.isUserInteractionEnabled = true
        cartIconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewCartAction)))
        return cartIconView
        
    }
    
    private (set) lazy var userImageView = getImageView(with: "user", action: #selector(handleViewProfileAction), rounded: true)
    private (set) lazy var cartImageView = getCartView()
    
}
