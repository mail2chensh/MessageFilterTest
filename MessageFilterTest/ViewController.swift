//
//  ViewController.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/19.
//

import UIKit
import IdentityLookup

class ViewController: UIViewController {
    
        
    @IBOutlet weak var keywordSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ================================
    // MARK:
    // ================================
    
    
    // 此处为演示动态增删关键词（规则），通过 App Group 实现数据共享
    @IBAction func keywordSwitchValueDidChanged(_ sender: Any) {
        //
        var keywordArr: [String] = ["京东"]
        //
        if self.keywordSwitch.isOn {
            keywordArr.append(contentsOf: ["淘宝", "天猫"])
        }
        //
        AppGroupUserDefault.widget.standard.set(keywordArr, forKey: "transactionalKeywordArray")
        AppGroupUserDefault.widget.standard.synchronize()
    }
    

}

