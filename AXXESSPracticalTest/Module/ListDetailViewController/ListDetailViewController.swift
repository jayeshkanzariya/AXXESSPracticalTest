//
//  ListDetailViewController.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {

    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblData : UILabel!
    
    var objData : ListDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        // Do any additional setup after loading the view.
    }
    
    // this method write for dependancy injection
    init?(coder: NSCoder, dataModel: ListDataModel) {
          self.objData = dataModel
          super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayData() {
        if let type = Section(rawValue: objData.type ?? "") {
            switch  type {
                case .Image :
                    lblData.isHidden = true
                    imgView.setImageWith(url: objData.data ?? "")
                default :
                    imgView.isHidden = true
                    lblData.text = objData.data ?? ""
                
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
