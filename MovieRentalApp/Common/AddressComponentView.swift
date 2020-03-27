//
//  AddressComponentView.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 27/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit

class AddressComponentView: UIView {
    
    lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addressView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = NSTextAlignment.left
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        textView.backgroundColor = UIColor.white
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        self.setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(placeHolderLabel)
        addSubview(addressView)
    }
    
    private func setUpContraints() {
        self.placeHolderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.placeHolderLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.addressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.addressView.topAnchor.constraint(equalTo: self.placeHolderLabel.bottomAnchor, constant: 8).isActive = true
        self.addressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.addressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
}
