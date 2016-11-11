//
//  AppDataItem.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct AppDataItem : Mappable {
    var name: String?
    var value: Any?
    var valueType: String?
    var outputOrder: Int?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["Name"]
        value <- map["Value"]
        valueType <- map["ValueType"]
        outputOrder <- map["OutputOrder"]
    }
}
