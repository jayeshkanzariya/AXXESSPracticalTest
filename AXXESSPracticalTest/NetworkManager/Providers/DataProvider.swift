//
//  DataProvider.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit
import Moya

// the cases which use for manage the user related apis
enum DataProvider {
    case getData
}

extension DataProvider : TargetType {
    
    // that is used get the base url
    var baseURL: URL {
        return URL(string : "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/")!
    }
    
    // that is used get the path for the request
    var path: String {
        switch self {
            case .getData: return "challenge.json"
        }
    }
    
    // that is used get the method for the request
    var method: Moya.Method {
        switch self {
            case .getData: return .get
        }
    }
    
    // that is used get the sample data for the request
    var sampleData: Data {
        return Data()
    }
    
    // that is used get task based on selected account user
    var task: Task {
        switch self {
            case .getData:
                return .requestPlain
        }
    }
    
    // that is used for getting header
    var headers: [String : String]? {
        return nil
    }
    
}
