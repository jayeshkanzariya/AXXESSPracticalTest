//
//  ListViewModel.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit

enum Section : String, CaseIterable {
    case Text = "text"
    case Image = "image"
    case Other = "other"
}

struct ListViewModel {
    
    var arrData = [ListDataModel]()
    var arrImageSectionData = [ListDataModel]()
    var arrTextSectionData = [ListDataModel]()
    var arrOtherSectionData = [ListDataModel]()
    
     func getData(success : @escaping (([ListDataModel]) -> ()),failure : @escaping ((String) -> ())) {
        if let reachable = Network.reachability?.isReachable,reachable {
            NetworkService.shared.callService(NetworkService.shared.dataProvider, type: DataProvider.getData, success: { (response : [ListDataModel]) in
                success(response)
                self.addDataOnRealmDataBase(data: response)
            }) { (message) in
                failure(message)
            }
        }
        else {
            success(getDataFromRealmDatabse())
        }
    }
    
    func addDataOnRealmDataBase(data : [ListDataModel]) {
        RealmManager.shared.addAndUpdateObjectsToRealm(realmList: data.map({$0.prepareForRealm()}))
    }
    
    func getDataFromRealmDatabse() -> [ListDataModel] {
         return Array(RealmManager.shared.realm.objects(ListDataModel.self))
    }
}
