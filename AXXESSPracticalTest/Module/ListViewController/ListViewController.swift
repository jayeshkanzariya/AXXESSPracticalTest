//
//  ListViewController.swift
//  AXXESSPracticalTest
//
//  Created by Jayesh on 25/07/20.
//  Copyright © 2020 Jayesh kanzariya. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    // Iboutlets
    @IBOutlet weak var tblView : UITableView!
    
    // ViewModel Object
    var objViewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tblView.register(ListTextSectionTableViewCell.self)
        tblView.register(ListImageSectionTableViewCell.self)
        // Do any additional setup after loading the view.
    }

    //MARK:- use for fetching data from api
    func loadData() {
        objViewModel.getData(success: { (arrList) in
            self.objViewModel.arrData = arrList
            self.objViewModel.arrImageSectionData = arrList.filter({$0.type == Section.Image.rawValue})
            self.objViewModel.arrTextSectionData = arrList.filter({$0.type == Section.Text.rawValue })
            self.objViewModel.arrOtherSectionData = arrList.filter({$0.type == Section.Other.rawValue })
            self.tblView.reloadData()
        }) { (message) in
            let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
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


extension ListViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section.allCases[indexPath.section] {
            case .Image:
                let cell : ListImageSectionTableViewCell = tableView.cellForItemAtIndexPath(indexPath: indexPath)
                cell.objData = objViewModel.arrImageSectionData[indexPath.row]
                return cell
            case .Text:
                let cell : ListTextSectionTableViewCell = tableView.cellForItemAtIndexPath(indexPath: indexPath)
                cell.objData = objViewModel.arrTextSectionData[indexPath.row]
                return cell
            case .Other:
                let cell : ListTextSectionTableViewCell = tableView.cellForItemAtIndexPath(indexPath: indexPath)
                cell.objData = objViewModel.arrOtherSectionData[indexPath.row]
                return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section.allCases[section] {
            case .Image:
                return objViewModel.arrImageSectionData.count
            case .Text:
                return objViewModel.arrTextSectionData.count
            case .Other:
                return objViewModel.arrOtherSectionData.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var objSelected : ListDataModel!
        switch Section.allCases[indexPath.section] {
            case .Image:
                objSelected = objViewModel.arrImageSectionData[indexPath.row]
            case .Text:
                objSelected = objViewModel.arrTextSectionData[indexPath.row]
            case .Other:
                objSelected = objViewModel.arrOtherSectionData[indexPath.row]
        }
        let detailVC = storyboard?.instantiateViewController(identifier: "ListDetailViewController", creator: { (coder) -> ListDetailViewController? in
            return ListDetailViewController(coder: coder, dataModel:  objSelected)
        })
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    
}
