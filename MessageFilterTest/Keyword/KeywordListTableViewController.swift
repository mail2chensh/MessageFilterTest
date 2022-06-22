//
//  KeywordListTableViewController.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/21.
//

import UIKit
import IdentityLookup

class KeywordListTableViewController: UITableViewController {
    
    var capabilityItem: ILMessageFilterSubAction = .none
    
    var keywordArray: [String] = []
    
    
    // ================================
    // MARK:
    // ================================
    
    convenience init(item: ILMessageFilterSubAction) {
        self.init()
        //
        self.capabilityItem = item
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "过滤[\(capabilityItem.getCapabilitiesZhText())]关键词"
        //
        let btn: UIBarButtonItem = UIBarButtonItem.init(title: "新增", style: .done, target: self, action: #selector(navigationBarRightButtonDidTouch))
        self.navigationItem.rightBarButtonItem = btn
        //
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        //
        self.keywordArray = KeywordManager.shared.getKeywordList(item: self.capabilityItem)
        self.tableView.reloadData()
        
    }
    
    @objc func navigationBarRightButtonDidTouch() {
        //
        let alertVC: UIAlertController = UIAlertController.init(title: "添加关键词", message: "", preferredStyle: .alert)
        var tempTextField = UITextField()
        alertVC.addTextField(configurationHandler: {
            textField in
            tempTextField = textField
            textField.placeholder = "请输入要过滤的关键词"
        })
        let cancleBtn: UIAlertAction = UIAlertAction.init(title: "取消", style: .cancel)
        let confirmBtn: UIAlertAction = UIAlertAction.init(title: "确定", style: .destructive) { action in
            //
            if let content = tempTextField.text {
                if content.count != 0 {
                    self.keywordArray.append(content)
                    KeywordManager.shared.updateKeywordList(item: self.capabilityItem, list: self.keywordArray)
                    self.tableView.reloadData()
                }
            }
        }
        alertVC.addAction(cancleBtn)
        alertVC.addAction(confirmBtn)
        self.present(alertVC, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.keywordArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //
        var content = cell.defaultContentConfiguration()
        content.text = self.keywordArray[indexPath.row]
        cell.contentConfiguration = content
        //
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            //
            self.keywordArray.remove(at: indexPath.row)
            KeywordManager.shared.updateKeywordList(item: capabilityItem, list: self.keywordArray)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
