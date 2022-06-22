//
//  ConstantName.swift
//  MessageFilterTest
//
//  Created by Chensh on 2022/6/20.
//

import Foundation
import IdentityLookup


let Capabilities_Key_Str: String = "Capabilities_Key_Str"

let SubAction_Keyword_Key_Str: String = "SubAction_Keyword_Key_Str"


let CapabilitiesDataArray: [[ILMessageFilterSubAction]] = [[.transactionalFinance,
                                                            .transactionalHealth,
                                                            .transactionalOrders,
                                                            .transactionalCarrier,
                                                            .transactionalRewards,
                                                            .transactionalReminders,
                                                            .transactionalPublicServices,
                                                            .transactionalWeather,
                                                            .transactionalOthers],
                                                           [.promotionalOffers,
                                                            .promotionalCoupons,
                                                            .promotionalOthers]]


extension ILMessageFilterSubAction {
    
    func getCapabilitiesZhText() -> String {
        switch self {
        case .transactionalFinance:
            return "财务"
        case .transactionalHealth:
            return "健康"
        case .transactionalOrders:
            return "订单"
        case .transactionalCarrier:
            return "运营商"
        case .transactionalRewards:
            return "奖励"
        case .transactionalReminders:
            return "提醒"
        case .transactionalPublicServices:
            return "公共服务"
        case .transactionalWeather:
            return "天气"
        case .transactionalOthers:
            return "其他"
        case .promotionalOffers:
            return "优惠券"
        case .promotionalCoupons:
            return "优惠"
        case .promotionalOthers:
            return "其他"
        case .none:
            return ""
        @unknown default:
            return ""
        }
    }
    
}
