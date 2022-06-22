//
//  KeywordTableViewController.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/21.
//

import UIKit
import IdentityLookup

class KeywordTableViewController: UITableViewController {
    
        
    var dataArray: [[ILMessageFilterSubAction]] = []
    
    // ================================
    // MARK:
    // ================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "过滤器子分类"
        //
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        //
        var transactionArray: [ILMessageFilterSubAction] = []
        var promotionalArray: [ILMessageFilterSubAction] = []
        //
        if let array: [Int] = AppGroupUserDefault.widget.standard.array(forKey: Capabilities_Key_Str) as? [Int] {
            for item in array {
                if item >= ILMessageFilterSubAction.promotionalOthers.rawValue {
                    promotionalArray.append(ILMessageFilterSubAction.init(rawValue: item) ?? .none)
                } else {
                    transactionArray.append(ILMessageFilterSubAction.init(rawValue: item) ?? .none)
                }
            }
        }
        self.dataArray = [transactionArray, promotionalArray]
        //
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //
        let item = self.dataArray[indexPath.section][indexPath.row]
        let title = item.getCapabilitiesZhText()
        //
        var content = cell.defaultContentConfiguration()
        content.text = title
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        //
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //
        let item = self.dataArray[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(KeywordListTableViewController(item: item), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "所有交易"
        } else {
            return "所有推广信息"
        }
    }
    
    
    
}
