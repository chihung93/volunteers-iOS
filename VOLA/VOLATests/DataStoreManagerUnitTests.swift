//
//  DataStoreManagerUnitTests.swift
//  VOLA
//
//  Created by Connie Nguyen on 7/26/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import XCTest
import RealmSwift
import Realm
@testable import VOLA

class DataStoreManagerUnitTests: XCTestCase {
    class MockDataStoreManager: DataStoreManagerProtocol {
        var realm = try! Realm()
    }

    var dataStoreManager = MockDataStoreManager()
    let user = User(uid: InputConstants.userUID, firstName: SplitNameConstants.standardFirstName, lastName: SplitNameConstants.standardLastName, email: InputConstants.validEmail)
    let user2 = User(uid: InputConstants.userUID2, firstName: SplitNameConstants.multiWordFirstName, lastName: SplitNameConstants.multiWordLastName, email: InputConstants.validEmailSpecialCharacter)
    let saveFailureMessage = "Should have saved user object."

    override func setUp() {
        super.setUp()

        // Clear out current realm
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        dataStoreManager.realm = try! Realm()
    }

    /// Test that user can be successfully saved to Realm data store
    func testSuccessSaveUserShouldSave() {
        let foundUsers = dataStoreManager.realm.objects(User.self)
        XCTAssertEqual(foundUsers.count, 0)

        do {
            try dataStoreManager.save(user)
        } catch {
            XCTFail(saveFailureMessage)
        }
        XCTAssertEqual(foundUsers.count, 1)
        let savedUser = foundUsers[0]
        XCTAssertEqual(user.firstName, savedUser.firstName)
        XCTAssertEqual(user.lastName, savedUser.lastName)
        XCTAssertEqual(user.email, savedUser.email)
    }

    /// Test that user load first returns user when user exists in data store
    func testSuccessLoadFirstShouldReturnUser() {
        let foundUsers = dataStoreManager.realm.objects(User.self)
        XCTAssertEqual(foundUsers.count, 0)

        do {
            try dataStoreManager.save(user)
        } catch {
            XCTFail(saveFailureMessage)
        }
        let firstUser = dataStoreManager.loadFirst(of: User.self)
        XCTAssertNotNil(firstUser)
        XCTAssertEqual(user.firstName, firstUser?.firstName)
        XCTAssertEqual(user.lastName, firstUser?.lastName)
        XCTAssertEqual(user.email, firstUser?.email)
    }

    /// Test that user load first returns a nil user if no users are saved in data store
    func testFailureLoadFirstShouldReturnNil() {
        let foundUsers = dataStoreManager.realm.objects(User.self)
        XCTAssertEqual(foundUsers.count, 0)
        let foundUser = dataStoreManager.loadFirst(of: User.self)
        XCTAssertNil(foundUser)
    }

    /// Test that all objects of a type are removed from data store
    func testSuccessDeleteAllShouldRemoveAllObjectsOfType() {
        let foundUsers = dataStoreManager.realm.objects(User.self)
        XCTAssertEqual(foundUsers.count, 0)

        let testUsers = [
            user,
            user2
        ]
        for user in testUsers {
            do {
                try dataStoreManager.save(user)
            } catch {
                XCTFail(saveFailureMessage)
            }
        }
        XCTAssertEqual(foundUsers.count, testUsers.count)

        do {
            try dataStoreManager.deleteAll(of: User.self)
        } catch {
            XCTFail(saveFailureMessage)
        }
        XCTAssertEqual(foundUsers.count, 0)
    }
}
