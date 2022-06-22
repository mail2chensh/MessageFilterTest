//
//  CapabilitiesTableViewController.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/20.
//

import UIKit
import IdentityLookup



class CapabilitiesTableViewController: UITableViewController {
    
        
    var selectedArray: [Int] = []
    
    
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
        if let arr: [Int] = AppGroupUserDefault.widget.standard.array(forKey: Capabilities_Key_Str) as? [Int] {
            self.selectedArray = arr
        }
        
        //
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return CapabilitiesDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CapabilitiesDataArray[section].count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         //
         let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
         //
         let item = CapabilitiesDataArray[indexPath.section][indexPath.row]
         let title = item.getCapabilitiesZhText()
         //
         var content = cell.defaultContentConfiguration()
         content.text = title
         content.image = UIImage(named: self.isItemSelected(item: item) ? "fav_2" : "fav_1")
         cell.contentConfiguration = content
         //
         return cell
     }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //
        let item = CapabilitiesDataArray[indexPath.section][indexPath.row]
        var isSelected = self.isItemSelected(item: item)
        isSelected.toggle()
        //
        self.updateSelectedArray(item: item, isSelected: isSelected)
        self.saveDataToLocol()
        //
        self.tableView.reloadData()
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
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    // ================================
    // MARK:
    // ================================
    
    
    func isItemSelected(item: ILMessageFilterSubAction) -> Bool {
        for selectedItem in self.selectedArray {
            if selectedItem == item.rawValue {
                return true
            }
        }
        return false
    }
    
    func updateSelectedArray(item: ILMessageFilterSubAction, isSelected: Bool) {
        if isSelected {
            self.selectedArray.append(item.rawValue)
        } else {
            for index in 0..<self.selectedArray.count {
                let  selectedItem = self.selectedArray[index]
                if selectedItem == item.rawValue {
                    self.selectedArray.remove(at: index)
                    return
                }
            }
        }
    }
    
    func saveDataToLocol() {
        AppGroupUserDefault.widget.standard.set(self.selectedArray, forKey: Capabilities_Key_Str)
        AppGroupUserDefault.widget.standard.synchronize()
    }
    
    
}
