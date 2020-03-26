//
//  AppDelegate.swift
//  MovieRentalApp
//
//  Created by Sarath Chenthamarai on 25/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        SessionUtils.initialize()
        RootRouter.shared.initialize(with: window!)
        window?.makeKeyAndVisible()
        
        return true
    }

}

