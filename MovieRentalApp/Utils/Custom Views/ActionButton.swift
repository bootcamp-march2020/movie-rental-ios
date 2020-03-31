//
//  ActionButton.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class ActionButton: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        addSubview(activityIndicator)
        
        button.fillSuperView(safeLayout: false)
        activityIndicator.alignCenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isEnabled: Bool {
        get { return button.isEnabled }
        set {
            button.isEnabled = newValue
            alpha = newValue ? 1 : 0.5
        }
    }
    
    func setTitle(_ title: String?, for state: UIControl.State) {
        button.setTitle(title, for: state)
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.button.isHidden = true
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.button.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    private (set) lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        view.layer.cornerRadius = 19
        view.layer.masksToBounds = true
        view.titleEdgeInsets = .init(top: 12, left: 20, bottom: 12, right: 20)
        return view
    }()
    
    private (set) lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setDimensions(width: 44, height: 44)
        view.hidesWhenStopped = true
        return view
    }()
    
}
