//
//  SessionManager.swift
//  MovieRentalApp
//
//  Created by Akaash Dev on 26/03/20.
//  Copyright © 2020 Sarath Chenthamarai. All rights reserved.
//

import GoogleSignIn

protocol SessionManagerProtocol {
    var isUserSignedIn: Bool { get }
    func getAccessToken() -> String?
}

class SessionManager: SessionManagerProtocol {
    
    static let shared = SessionManager()
    
    var isUserSignedIn: Bool {
        return GIDSignIn.sharedInstance()?.currentUser != nil
    }
    
    var currentUser: GIDGoogleUser {
        guard let user = GIDSignIn.sharedInstance()?.currentUser else {
            RootRouter.shared.setRootViewController(animated: true)
            return GIDGoogleUser()
        }
        return user
    }
    
    func initialize() {
        GIDSignIn.sharedInstance()?.clientID = Config.CLIENT_ID
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func getAccessToken() -> String? {
        guard isUserSignedIn else { return nil }
        return currentUser.authentication.idToken
    }
    
    func handleSignOut() {
        GIDSignIn.sharedInstance()?.signOut()
        RootRouter.shared.setRootViewController(animated: true)
    }
    
}
