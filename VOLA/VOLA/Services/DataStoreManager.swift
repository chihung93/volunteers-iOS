//
//  DataStoreManager.swift
//  VOLA
//
//  Created by Connie Nguyen on 7/20/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import Foundation
import RealmSwift

/// Protocol for class definition for DataStoreManager and mocks for unit testing
protocol DataStoreManagerProtocol {
    var realm: Realm { get set }
}

/**
Extension for DataStoreManagerProtocol for common functions that are by
 DataStoreManager or by a mocked class for testing
*/
extension DataStoreManagerProtocol {
    /**
     Save data model to persisted data store

     - Parameters:
     - object: Realm data model to save
     - replace: Boolean whether or not object should be overwritten
     */
    func save<T: Object>(_ object: T, replace: Bool = false) throws {
        try realm.write {
            realm.add(object, update: replace)
        }
    }

    /**
     Load first data model of give type from data store if it exists

     - Parameters:
     - type: Realm object type to retrieve first of

     - Returns: First of given type if it exists in data store, otherwise returns nil
     */
    func loadFirst<T: Object>(of type: T.Type) -> T? {
        return realm.objects(type).first
    }

    /**
     Delete all objects in data store of given type

     - Parameters:
     - type: Realm object type to delete
     */
    func deleteAll<T: Object>(of type: T.Type) throws {
        let deleteObjects = realm.objects(type)
        try realm.write {
            realm.delete(deleteObjects)
        }
    }
}

/// Manager for saving and retrieving models from a persisted data store
final class DataStoreManager: DataStoreManagerProtocol {
    static let shared = DataStoreManager()

    var realm = try! Realm()
}
