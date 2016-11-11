//
//  LoginResponse.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct LoginResponse: Mappable {
    var apiKey: String?
    var username: String?
    var hospitalService: String?
    var earliestHistoricalDate: Date?
    var latestHistoricalDate: Date?
    var modules: [Module]?
    var siteInfo: SiteInfo?
    var keyCode: String?
    var clinicalRole: String?
    var commProtocol: String?
    
    var admissionsProcessModule: Module {
        return (modules?.filter({
            $0.modName == "Admissions Process Module"
        })[0])!
    }
    var dynamicAssessmentModule: Module?{
        return (modules?.filter({
            $0.modName == "Dynamic Assessment Module"
        })[0])!
    }
    var admissionPredictorModule: Module?{
        return (modules?.filter({
            $0.modName == "Admission Predictor Module"
        })[0])!
    }
    var psychiatricEDModule: Module?{
        return (modules?.filter({
            $0.modName == "Psychiatric ED Module"
        })[0])!
    }

    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        apiKey <- map["APIKey"]
        username <- map["Username"]
        hospitalService <- map["HospitalService"]
        earliestHistoricalDate <- (map["EarliestHistoricalDate"], DateYearTransform())
        latestHistoricalDate <- (map["LatestHistoricalDate"], DateYearTransform())
        modules <- map["Modules"]
        siteInfo <- map["SiteInfo"]
        keyCode <- map["KeyCode"]
        clinicalRole <- map["ClinicalRole"]
        commProtocol <- map["CommProtocol"]
    }

}
