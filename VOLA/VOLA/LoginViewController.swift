//
//  LoginViewController.swift
//  VOLA
//
//  Created by Connie Nguyen on 5/31/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import UIKit
import FRHyperLabel
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signUpLabel: VLHyperLabel!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!

    var introSender: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up viewController for social login
        GIDSignIn.sharedInstance().uiDelegate = self

        facebookLoginButton.readPermissions = FBRequest.readPermissions
        facebookLoginButton.delegate = self

        // Set up Cancel button to dismiss
        if !introSender {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelPressed))
        }

        // Handle hyper label set up
        let labelText = "signup.title.label".localized
        signUpLabel.setAttributedString(labelText, fontSize: 16.0)
        let signUpHandler = {(hyperLabel: FRHyperLabel?, substring: String?) -> Void in
            self.onSignUpPressed()
        }
        signUpLabel.setLinkForSubstring("signup.prompt.title.label".localized, withLinkHandler: signUpHandler)

        NotificationCenter.default.addObserver(self, selector: #selector(googleDidSignIn(_:)), name: NotificationName.googleDidSignIn, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard DataManager.shared.currentUser == nil else {
            dismiss(animated: true, completion: nil)
            return
        }
    }

    @IBAction func onLoginWithEmailPressed(_ sender: Any) {
        performSegue(.showLoginManual)
    }

    func onSignUpPressed() {
        guard let storyboard = storyboard else {
            Logger.error("Storyboard for LoginViewController was nil.")
            return
        }

        let signUpVC: SignUpViewController = storyboard.instantiateViewController()
        navigationController?.show(signUpVC, sender: self)
    }

    func onCancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        guard let response = result, response.token != nil else {
            Logger.error("Facebook response or access token is nil.")
            return
        }

        LoginManager.shared.loginFacebook { (error) in
            guard error == nil else {
                Logger.error(error?.localizedDescription ?? "Facebook log in service returned an error.")
                return
            }

            self.onCancelPressed()
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        // TODO - func is required to be defined as a FBSDKLoginButtonDelegate
    }
}

//MARK: - NotificationObserver
extension LoginViewController {
    func googleDidSignIn(_ notification: NSNotification) {
        LoginManager.shared.loginGoogle(notification: notification) { (error) in
            guard error == nil else {
                Logger.error(error?.localizedDescription ?? "Error while attempting to log in with Google.")
                return
            }

            self.onCancelPressed()
        }
    }
}
