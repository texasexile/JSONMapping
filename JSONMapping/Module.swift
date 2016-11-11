//
//  Module.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct Module : Mappable {
    var modName: String?
    var modVersion: String?
    var payloadCodes: [String]?
    var modId: String?
    
    // for Admissions Process Module
    var admitSpecialNeeds: [AppDataItem]?
    var d2sExtrheshReasons: [AppDataItem]?
    var arqCancelReasons: [AppDataItem]?
    var admitRequestBedTypes: [AppDataItem]?
    
    // for Dynamic Assessment Module
    var assessmentPrecautions: [AppDataItem]?
    var assessmentDatatypes: [AppDataItem]?
    
    // for Admission Predictor Module
    // (none)
    
    // for Psychiatric ED Module
    // (none)
 
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        modName <- map["ModName"]
        
        admitSpecialNeeds <- map ["AppData.ADMIT_SPECIAL_NEEDS"]
        d2sExtrheshReasons <- map["AppData.D2S_EXTHRESH_REASONS"]
        arqCancelReasons <- map["AppData.ARQ_CANCEL_REASONS"]
        admitRequestBedTypes <- map["AppData.ADMIT_REQUEST_BED_TYPES"]
        assessmentPrecautions <- map["AppData.ASSESSMENT_PRECAUTIONS"]
        assessmentDatatypes <- map["AppData.ASSESSMENT_DATATYPES"]
        
        modVersion <- map["ModVersion"]
        payloadCodes <- map["PayloadCodes"]
        modId <- map["ModId"]
    }
}
