//
//  RealmManager.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RealmManager: NSObject {
    
    override init() {
        let configuration = Realm.Configuration()
        realm = try! Realm(configuration: configuration)
    }
    
    static let shared = RealmManager.init()
    
    var realm: Realm!
    
    func printRealmPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func clearDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
    //Method to add and update list of record into database
    func addAndUpdateObjectsToRealm(realmList: [Object]) {        
        try! realm.write {
            realm.add(realmList, update: .all)
        }
    }
    
}
