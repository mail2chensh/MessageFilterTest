//
//  AppGroupUserDefault.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/19.
//

import Foundation


public enum AppGroupUserDefault: String {
    
    case widget = "group.com.company.MessageFilterTest"

    
    public var standard: UserDefaults {
        switch self {
        case .widget:
            if let ud = UserDefaults.init(suiteName: self.rawValue) {
                return ud
            } else {
                return UserDefaults.standard
            }
        }
    }
    
}
