//
//  ClinicalUnit.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct ClinicalUnit: Mappable {
    var roomsInUnit: [Room]?
    var unitId: Int?
    var isEd: Bool?
    var unitHL7PointOfCareCode: String?
    var displayNames: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        roomsInUnit <- map["RoomsInUnit"]
        unitId <- map["UnitId"]
        isEd <- map["IsED"]
        unitHL7PointOfCareCode <- map["UnitHL7PointOfCareCode"]
        displayNames <- map["DisplayNames"]
    }
    
}
