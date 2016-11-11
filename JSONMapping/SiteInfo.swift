//
//  SiteInfo.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct SiteInfo: Mappable {
    var assessments: [AssessmentDetail]?
    var hospitalServices: [HospitalService]?
    var videos: [Video]?
    var clinicalRoles: [String]?
    var clinicalUnits: [ClinicalUnit]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        assessments <- map["Assessments"]
        hospitalServices <- map["HospitalServices"]
        videos <- map["Videos"]
        clinicalRoles <- map["ClinicalRoles"]
        clinicalUnits <- map["ClinicalUnits"]
    }
}
