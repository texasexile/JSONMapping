//
//  PatientDisposition.swift
//  BP_App_Framework
//
//  Created by BluPanda on 5/13/16.
//  Copyright © 2016 BluPanda. All rights reserved.
//

import Foundation

public enum PatientDisposition: String {
    case abandoned
    case admitted
    case discharged
    case new
    case unknown
    case updated
}

struct Disposition {
    var disposition: PatientDisposition
    
    init (updateCode: String) {
        switch updateCode {
        case "DP":
            self.disposition = .discharged
        case "AP":
            self.disposition = .admitted
        case "XP":
            self.disposition = .abandoned
        case "RP":
            self.disposition = .abandoned
        case "NP":
            self.disposition = .new
        case "UP":
            self.disposition = .updated
        default:
            self.disposition = .unknown
        }
    }
    
    func label() -> String {
        return self.disposition.rawValue
    }
}
