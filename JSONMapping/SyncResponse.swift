//
//  SyncResponse.swift
//  JSONMapping
//
//  Created by Ted Conley on 11/2/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct SyncResponse: Mappable {
    var lastId: Int?
    var code: ServerResultCode?
    var message: String?
    var patientVisits: [PatientVist]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        lastId <- map["LastId"]
        code <- map["Code"]
        message <- map["Message"]
        patientVisits <- map["Value"]
    }

}
