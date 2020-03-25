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
    
    var imageUrl: String?
    
    func loadImageUsingURLString(_ url: String) {
        
        imageUrl = url
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        APIManager.shared.makeAPICall(url) { (result) in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                DispatchQueue.main.async(execute: {
                    if let imageToCache = UIImage(data: data) {
                        if self.imageUrl == url {
                            self.image =  imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    }
                })
            }
        }
    }
}
