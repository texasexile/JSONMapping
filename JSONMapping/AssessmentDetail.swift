//
//  AssessmentDetail.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct AssessmentDetail: Mappable {
    var packId: String?
    var url: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        packId <- map["PACKID"]
        url <- map["URL"]
    }
}
