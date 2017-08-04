//
//  SocialNetworkingAuthenticationStrategy.swift
//  VOLA
//
//  Created by Connie Nguyen on 6/16/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import Foundation
import PromiseKit
import FirebaseAuth

/// Protocol for user authentication (social login and manual) for user with LoginManager
protocol SocialNetworkingAuthenticationStrategy {
    func login() -> Promise<User>
}

// Extension of SocialNetworkingAuthenticationStrategy with functions common across different strategies
extension SocialNetworkingAuthenticationStrategy {
    /**
        Login to Firebase using `credential` for a provider login
     
        - Parameters:
            - credential: Credential for a provider login
     
        - Returns: User Promise of connected Firebase user
    */
    func loginToFirebase(_ credential: FIRAuthCredential) -> Promise<User> {
        return Promise { fulfill, reject in
            FIRAuth.auth()?.signIn(with: credential, completion: { (firebaseUser, error) in
                guard let user = firebaseUser, error == nil else {
                    let signInError = error ?? VLError.invalidFirebaseAction
                    reject(signInError)
                    return
                }

                fulfill(User(firebaseUser: user))
            })
        }
    }
}

/**
    Available user authentication strategies

    - facebook: Login through Facebook
    - google: Login through Google
    - emailSignup: Sign up for an account (implicit login)
    - emailLogin: Login using email and password
    - custom: Use for testing/mocking purposes
*/
enum AvailableLoginStrategies {
    case facebook
    case google(NSNotification)
    case emailSignup(name: String, email: String, password: String)
    case emailLogin(email: String, password: String)
    case custom(Promise<User>)
}

// MARK: - SocialNetworkingAuthenticationStrategy
extension AvailableLoginStrategies: SocialNetworkingAuthenticationStrategy {
    /// Login based on user authentication strategy
    func login() -> Promise<User> {
        switch self {
        case .facebook:
            return FacebookAuthenticationStrategy().login()
        case .google(let notification):
            return GoogleAuthenticationStrategy(notification: notification).login()
        case .emailSignup(let name, let email, let password):
            return EmailSignUpStrategy(name: name, email: email, password: password).login()
        case .emailLogin(let email, let password):
            return EmailLoginStrategy(email: email, password: password).login()
        case .custom(let promise):
            return promise
        }
    }
}

// MARK: - SocialNetworkingAuthenticationStrategy
/// Strategy for user authentication via Facebook
struct FacebookAuthenticationStrategy: SocialNetworkingAuthenticationStrategy {
    /**
        Use Facebook access token to login to Firebase connected account
     
        - Returns: User promise populated with data from connected Firebase user if sucessful
    */
    func login() -> Promise<User> {
        return Promise { fulfill, reject in
            guard let fbTokenString = FBSDKAccessToken.current().tokenString else {
                reject(AuthenticationError.invalidFacebookToken)
                return
            }

            let credential = FIRFacebookAuthProvider.credential(withAccessToken: fbTokenString)
            loginToFirebase(credential)
                .then { user -> Void in
                    fulfill(user)
                }.catch { error in
                    reject(error)
                }
        }
    }
}

// MARK: - SocialNetworkingAuthenticationStrategy
/**
    Strategy for user authentication via Google
 
    - `notification`: Notification passed from Google sign in delegate with Google user data
*/
struct GoogleAuthenticationStrategy: SocialNetworkingAuthenticationStrategy {
    let notification: NSNotification

    /**
        Use authenticated Google user data from `notification` to login to Firebase connected account
     
        - Returns: User promise populated with data from connected Firebase user if successful
    */
    func login() -> Promise<User> {
        return Promise { fulfill, reject in
            guard let googleUser = notification.userInfo?[DictKeys.user.rawValue] as? GIDGoogleUser,
                let authentication = googleUser.authentication else {
                reject(AuthenticationError.invalidGoogleUser)
                return
            }

            let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            loginToFirebase(credential)
                .then { user -> Void in
                    fulfill(user)
                }.catch { error in
                    reject(error)
                }
        }
    }
}

// MARK: - SocialNetworkingAuthenticationStrategy
/**
    Strategy for creating a new user account on Firebase and implicitly logging in through signup
 
    - `name`: Full name for new user
    - `email`: Email address to sign up with and use for login
    - `password`: Password to sign up with and user for login
*/
struct EmailSignUpStrategy: SocialNetworkingAuthenticationStrategy {
    let name: String
    let email: String
    let password: String

    /**
        Create new Firebase user account and updated user information on Firebase to match `name`
     
        - Returns: User promise populated with data from connected Firebase user if successful
    */
    func login() -> Promise<User> {
        return Promise { fulfill, reject in
            guard let firebaseAuth = FIRAuth.auth() else {
                reject(AuthenticationError.invalidFirebaseAuth)
                return
            }

            firebaseAuth.createUser(withEmail: email, password: password, completion: { (user, signUpError) in
                guard let firebaseUser = user else {
                    let error = signUpError ?? AuthenticationError.invalidFirebaseAuth
                    reject(error)
                    return
                }

                // TODO: Save/set user to Firebase
                //FirebaseDataManager.shared.setUser(email: self.email)
                let changeRequest = firebaseUser.profileChangeRequest()
                changeRequest.displayName = self.name
                changeRequest.commitChanges(completion: { (profileError) in
                    guard profileError == nil else {
                        let error = profileError ?? AuthenticationError.invalidFirebaseAuth
                        reject(error)
                        return
                    }

                    fulfill(User(firebaseUser: firebaseUser))
                })
            })
        }
    }
}

// MARK: - SocialNetworkingAuthenticationStrategy
/**
    Strategy for logging in to a Firebase account manually
 
    - `email`: Email address to login wtih
    - `password`: Password to login with
*/
struct EmailLoginStrategy: SocialNetworkingAuthenticationStrategy {
    let email: String
    let password: String

    /**
        Login to Firebase account given an `email` and `password`
     
        - Returns: Use promise populated with data from connected Firebase user if successful
    */
    func login() -> Promise<User> {
        return Promise { fulfill, reject in
            let credential = FIREmailPasswordAuthProvider.credential(withEmail: email, password: password)
            loginToFirebase(credential)
                .then { user -> Void in
                    fulfill(user)
                }.catch { error in
                    reject(error)
                }
        }
    }
}
