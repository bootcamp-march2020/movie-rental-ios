//
//  SessionUtils.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import GoogleSignIn

protocol SessionUtilsProtocol {
    static var isUserSignedIn: Bool { get }
    static func getAccessToken() -> String?
}

class SessionUtils: SessionUtilsProtocol {
    
    static var isUserSignedIn: Bool {
        return GIDSignIn.sharedInstance()?.currentUser != nil
    }
    
    static var currentUser: GIDGoogleUser {
        guard let user = GIDSignIn.sharedInstance()?.currentUser else {
            RootRouter.shared.setRootViewController(animated: true)
            return GIDGoogleUser()
        }
        return user
    }
    
    static func initialize() {
        GIDSignIn.sharedInstance()?.clientID = CONFIG.CLIENT_ID
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    static func getAccessToken() -> String? {
        guard isUserSignedIn else { return nil }
        return currentUser.authentication.idToken
    }
    
    static func handleSignOut() {
        GIDSignIn.sharedInstance()?.signOut()
        RootRouter.shared.setRootViewController(animated: true)
    }
    
}
