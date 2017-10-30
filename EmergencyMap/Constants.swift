//
//  Constants.swift
//  EmergencyMap
//
//  Created by Laurie Wheeler on 10/15/17.
//  Copyright © 2017 Student. All rights reserved.
//

struct Constants {
    
    struct NotificationKeys {
        static let SignedIn = "onSignInCompleted"
    }
    
    struct Segues {
        //static let SignInToFp = "SignInToFP"
        static let SignInToVC = "SignInToMapViewController"
        static let FpToSignIn = "FPToSignIn"
    }
    
    struct MessageFields {
        static let name = "name"
        static let text = "text"
        static let photoURL = "photoURL"
        static let imageURL = "imageURL"
    }
}
