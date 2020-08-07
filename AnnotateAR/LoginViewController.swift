//
//  LoginViewController.swift
//  AnnotateAR
//
//  Created by Tyler Franklin on 3/29/20.
//  Copyright © 2020 Tyler Franklin. All rights reserved.
//

import FirebaseUI
import UIKit

enum Keys: String {
    case deviceToken = "device_token"
}

class LoginViewController: UIViewController, FUIAuthDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesBackButton = true
        let CurrentUser = Auth.auth().currentUser
        if CurrentUser != nil {
            showList()
        } else {
            let authUI = FUIAuth.defaultAuthUI()
            authUI?.delegate = self
            let providers: [FUIAuthProvider] = [
                FUIGoogleAuth(),
            ]

            authUI?.providers = providers

            let authViewController = authUI!.authViewController()
            present(authViewController, animated: true, completion: nil)
        }
    }

    func authUI(_: FUIAuth, didSignInWith _: AuthDataResult?, error _: Error?) {
        let deviceToken = UserDefaults.standard.string(forKey: Keys.deviceToken.rawValue)
        // check that the user doesn't already exist!
        AnnotationService().saveNewUser(deviceToken: deviceToken, callback: nil)
        showList()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard
            let viewController = segue.destination as? AnnotationListViewController
        else { return }

        viewController.viewModel = AnnotationListViewModel(viewData: AnnotationListViewData(annotations: []))
    }

    private func showList() {
        performSegue(withIdentifier: "showList", sender: self)
    }
}
