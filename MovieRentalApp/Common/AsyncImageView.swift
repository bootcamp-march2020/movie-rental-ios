//
//  AsyncImageView.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//


import Foundation
import UIKit

let imageCache =  NSCache<AnyObject, AnyObject>()

class AsyncImageView: UIImageView {
    
    var imageUrl: URL?
    
    func loadImage(with url: URL) {
        imageUrl = url
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        APIManager.shared.makeAPICall(with: URLRequest(url: url)) { (result) in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data) {
                        if self.imageUrl == url {
                            self.image =  imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    }
                }
            }
        }
    }
    
    func loadImageUsingURLString(_ url: String) {
        image = nil
        guard let url_ = URL(string: url) else { return }
        loadImage(with: url_)
    }
}
