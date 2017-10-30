//
//  SigninViewController.swift
//  EmergencyMap
//
//  Created by Laurie Wheeler on 10/15/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn

@objc(SignInViewController)
class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("signin viewdidload")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            if user != nil {
                MeasurementHelper.sendLoginEvent()
                self.performSegue(withIdentifier: Constants.Segues.SignInToVC, sender: nil)
            }
        }
        
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}

