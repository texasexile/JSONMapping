//
//  HospitalService.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct HospitalService: Mappable {
    var hospServiceId: Int?
    var hospServiceName: String?
    var hospServiceAbbr: String?
    var hospServiceOutputOrder: Int?
    var hospServiceUnits: [String]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        hospServiceId <- map["HospServiceId"]
        hospServiceName <- map["HospServiceName"]
        hospServiceAbbr <- map["HospServiceAbbr"]
        hospServiceOutputOrder <- map["HospServiceOutputOrder"]
        hospServiceUnits <- map["HospServiceUnits"]
    }
}
