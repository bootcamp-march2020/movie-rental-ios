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
    }
    
    @objc private func handleViewProfileAction() {
        present(UserProfileController(), animated: true)
    }
    
    @objc private func handleViewCartAction() {
        print("Cart")
    }
    
    private func getImageView(with imageNamed: String, action: Selector) -> UIImageView {
        let view = UIImageView(image: UIImage(named: imageNamed))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setConstantWidth(32)
        view.setConstantHeight(32)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        return view
    }
    
    private (set) lazy var userImageView = getImageView(with: "user", action: #selector(handleViewProfileAction))
    private (set) lazy var cartImageView = getImageView(with: "cart", action: #selector(handleViewCartAction))
    
}
