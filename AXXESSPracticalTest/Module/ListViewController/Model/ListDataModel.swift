//
//  ListDataModel.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class BaseLocalDatabaseModel: Object {
    
    @objc dynamic var idField: String = ""
    
}


class ListDataModel: BaseLocalDatabaseModel,Codable {

    @objc dynamic var data : String?
    @objc dynamic var date : String?
    @objc dynamic var id: String = ""
    @objc dynamic var type : String?


    enum CodingKeys: String, CodingKey {
        case data = "data"
        case date = "date"
        case id = "id"
        case type = "type"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func prepareForRealm() -> ListDataModel {
        let newObject = ListDataModel()
        newObject.id = id
        newObject.data = data
        newObject.date = date
        newObject.type = type
        return newObject
    }

}
