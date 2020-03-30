//
//  LoginViewController.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/29/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import FirebaseUI
import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Auth.auth().currentUser != nil {
        } else {
            guard let authUI = FUIAuth.defaultAuthUI()
            else { return }

            authUI.delegate = self as? FUIAuthDelegate
            authUI.providers = [
                FUIGoogleAuth(),
            ]

            let authViewController = authUI.authViewController()
            present(authViewController, animated: true, completion: nil)
        }
    }
}
