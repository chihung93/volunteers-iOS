//
//  FirebaseDataManager.swift
//  VOLA
//
//  Created by Connie Nguyen on 7/29/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseAuth.FIRUser
import FirebaseDatabase
import PromiseKit

/// Class for managing reading from and writing to Firebase realtime database
class FirebaseDataManager {
    enum UserTableField: String {
        case email

        var key: String {
            return rawValue
        }
    }

    static let shared = FirebaseDataManager()

    let reference = Database.database().reference()

    private init() { /* intentionally left blank */ }

    /**
        Retrieve user from Firebase realtime database given a `FIRUser`
     
        - Parameters:
            - firebaseUser: Firebase user associated with user in Firebase database table
     
        - Returns: `User` promise populated with data from Firebase account and user database
            if successful
    */
    func userFromTable(firebaseUser: FirebaseAuth.User) -> Promise<User?> {
        return Promise { fulfill, reject in
            reference.table(.users).child(firebaseUser.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let snapshotDict = snapshot.value as? [String: Any] else {
                    // No user with matching UID exists on Firebase database
                    fulfill(nil)
                    return
                }

                let userFromSnapshot = User(firebaseUser: firebaseUser, snapshotDict: snapshotDict)
                guard let userInDatabase = userFromSnapshot else {
                    reject(VLError.failedUserSnapshot)
                    return
                }

                fulfill(userInDatabase)
            }) { (error) in
                reject(error)
            }
        }
    }

    /**
        Create or update a user in the Firebase realtime database given a `FirebaseAuth.User`
     
        - Parameters:
            - firebaseUser: Firebase user to create a new user object in Firebase table for
     
        - Returns: `User` promise populated with data from Firebase account and user database
            if successful
    */
    func updateUserInTable(firebaseUser: FirebaseAuth.User, values: [String: Any]) -> Promise<User> {
        return Promise { fulfill, reject in
            reference.table(.users).child(firebaseUser.uid).setValue(values)
            reference.table(.users).child(firebaseUser.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let snapshotDict = snapshot.value as? [String: Any] else {
                    reject(VLError.invalidFirebaseAction)
                    return
                }

                let userFromSnapshot = User(firebaseUser: firebaseUser, snapshotDict: snapshotDict)
                guard let newUser = userFromSnapshot else {
                    reject(VLError.failedUserSnapshot)
                    return
                }

                fulfill(newUser)
            }) { (error) in
                reject(error)
            }
        }
    }
}
