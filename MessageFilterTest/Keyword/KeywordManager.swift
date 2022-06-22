//
//  KeywordManager.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/21.
//

import Foundation
import IdentityLookup

class KeywordManager {
    
    static let shared: KeywordManager = KeywordManager.init()
    
    var dict: [String: [String]] = [:]
    
    // ================================
    // MARK:
    // ================================
    
    init() {
        if let content: String = AppGroupUserDefault.widget.standard.string(forKey: SubAction_Keyword_Key_Str) {
            if let locol: [String: [String]] = content.toDictionary() as? [String: [String]] {
                self.dict = locol
            }
        }
    }
    
    
    func getKeywordList(item: ILMessageFilterSubAction) -> [String] {
        if dict.keys.contains("\(item.rawValue)") {
            return dict["\(item.rawValue)"] ?? []
        } else {
            return []
        }
    }
    
    func updateKeywordList(item: ILMessageFilterSubAction, list: [String]) {
        //
        dict["\(item.rawValue)"] = list
        //
        if let content = dict.toJsonString() {
            AppGroupUserDefault.widget.standard.set(content, forKey: SubAction_Keyword_Key_Str)
            AppGroupUserDefault.widget.standard.synchronize()
        }
    }
    
    // ================================
    // MARK:
    // ================================
    
    func isMatchKeyword(content: String) -> (ILMessageFilterAction, ILMessageFilterSubAction) {
        for (key, valueList) in self.dict {
            for value in valueList {
                if content.contains(value) {
                    //
                    let subAction = ILMessageFilterSubAction.init(rawValue: Int(key) ?? 0) ?? .none
                    //
                    return (self.getFilterAction(item: subAction), subAction)
                }
            }
        }
        //
        return (.none, .none)
    }
    
    func getFilterAction(item: ILMessageFilterSubAction) -> ILMessageFilterAction {
        if item.rawValue >= ILMessageFilterSubAction.promotionalOthers.rawValue {
            return ILMessageFilterAction.promotion
        } else {
            return ILMessageFilterAction.transaction
        }
    }
    
}



// MARK: 字典转字符串
extension Dictionary {
    
    func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                     options: []) else {
            return nil
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
     }
    
}

// MARK: 字符串转字典
extension String {
    
    func toDictionary() -> [String : Any] {
        
        var result = [String : Any]()
        guard !self.isEmpty else { return result }
        
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                           options: .mutableContainers) as? [String : Any] {
            result = dic
        }
        return result
    
    }
    
}
