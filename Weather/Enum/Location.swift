//
//  Location.swift
//  Weather
//
//  Created by Dong on 2024/4/15.
//

import Foundation

enum Location: String, CaseIterable {
    case current = "現在位置"
    case klu = "基隆市", tph = "新北市", tpe = "臺北市"
    case tyc = "桃園市", hsh = "新竹縣", hsc = "新竹市"
    case mal = "苗栗縣", txg = "臺中市", cwh = "彰化縣"
    case nto = "南投縣", ylh = "雲林縣", chy = "嘉義縣"
    case cyi = "嘉義市", tnn = "臺南市", khh = "高雄市"
    case iuh = "屏東縣", iln = "宜蘭縣", hwa = "花蓮縣"
    case ttt = "臺東縣", peh = "澎湖縣"
    case kmn = "金門縣", lnn = "連江縣"
}

extension Location {
    static var locationDict = Dictionary(uniqueKeysWithValues: Location.allCases.map { (String(describing: $0), $0.rawValue) })
    
    static func from(string: String) -> Location? {
        guard let rawValue = locationDict[string]
        else { return nil }
        
        return Location(rawValue: rawValue)
    }
}
