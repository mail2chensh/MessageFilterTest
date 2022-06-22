//
//  ViewController.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/19.
//

import UIKit
import IdentityLookup

class ViewController: UIViewController {
    
        

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        if let url = URL(string: "http://www.baidu.com") {
            let request = URLRequest(url: url)
            let session = URLSession.init(configuration: URLSessionConfiguration.default)
            let dataTask = session.dataTask(with: request) { data, response, error in
                debugPrint(data as Any, response as Any, error as Any)
            }
            dataTask.resume()
        }
    }
    
    
    // ================================
    // MARK:
    // ================================
    
    @IBAction func changeSubActionButtonDidTouch(_ sender: Any) {
        self.navigationController?.pushViewController(CapabilitiesTableViewController(), animated: true)
    }
    
    @IBAction func changeKeywordButtonDidTouch(_ sender: Any) {
        self.navigationController?.pushViewController(KeywordTableViewController(), animated: true)
    }

}

