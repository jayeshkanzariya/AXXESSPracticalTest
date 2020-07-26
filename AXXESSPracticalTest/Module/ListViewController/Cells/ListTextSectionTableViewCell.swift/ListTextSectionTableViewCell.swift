//
//  ListTextSectionTableViewCell.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit

class ListTextSectionTableViewCell: UITableViewCell,NibLoadableView,ReusableView {

    @IBOutlet weak var lblTitle : UILabel!
    
    var objData : ListDataModel! {
        didSet {
            lblTitle.text = objData.data ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
