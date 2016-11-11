//
//  PatientVisit.swift
//  JSONMapping
//
//  Created by Ted Conley on 11/2/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

public struct PatientVist: Mappable {
    var accountNumber: String?
    var acuity: Int?
    var allergies: String?
    var arrivalDateTime: Date?
    var arrivalTimeString: String {
        if let date = arrivalDateTime {
            return date.dateTimeString()
        } else {
            return ""
        }
    }
    var assessmentDate: Date?
    var assessmentTimeString: String {
        if let date = assessmentDate {
            return date.dateTimeString()
        } else {
            return ""
        }
    }
    var bed: String?
    var bpSys: Int?
    var bpDia: Int?
    var breathalyzer: Float?
    var cc: String?
    var dateOfBirth: Date?
    var dateOfBirthString: String {
        if let date = dateOfBirth {
            return date.dateString()
        } else {
            return ""
        }
    }
    var departureDateTime: Date?
    var diags: String?
    var disposition = PatientDisposition.unknown
    var heartRate: Int?
    var erRoom: String?
    var eventDescription: String?
    var examDate: Date?
    var examTimeString: String {
        if let date = examDate {
            return date.dateTimeString()
        } else {
            return ""
        }
    }
    var glucometer: Int?
    var height: Float?
    var language: String?
    var medications: String?
    var moa: ModeOfArrival?
    var mrn: String?
    var optrFirstname : String?
    var optrLastname : String?
    var patientClass: String?
    var precautions: String?
    var pointOfCare: String?
    var pulse: Int?
    var pvid: Int?
    var respiration: Int?
    var rfv: String?
    var room: String?
    var specialNeeds: String?
    var substances: String?
    var temp: Float?
    var triageDate: Date?
    var triageTimeString: String {
        if let date = triageDate {
            return date.dateTimeString()
        } else {
            return ""
        }
    }
    var vitalsDate: Date?
    var vitalsTimeString: String {
        if let date = vitalsDate {
            return date.dateTimeString()
        } else {
            return ""
        }
    }
    var weight: Float?
    
    let dateTimeOptions = [ISO8601DateFormatter.Options.withYear,
                           ISO8601DateFormatter.Options.withMonth,
                           ISO8601DateFormatter.Options.withDay,
                           ISO8601DateFormatter.Options.withTime,
                           ISO8601DateFormatter.Options.withDashSeparatorInDate,
                           ISO8601DateFormatter.Options.withColonSeparatorInTime] as ISO8601DateFormatter.Options
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        accountNumber <- map["ACT"]
        acuity <- map["ESI"]
        allergies <- map["ALLERGIES"]
        arrivalDateTime <- (map["DTARRIVAL"], ISO8601DateFormatterTransform(options: dateTimeOptions))
        assessmentDate <- (map["DT_ASSESS"], ISO8601DateFormatterTransform(options: dateTimeOptions))
        bed <- map["BED"]
        bpDia <- map["BPDIA"]
        bpSys <- map["BPSYS"]
        breathalyzer <- map["BRALYZ"]
        cc <- map["CC"]
        dateOfBirth <- (map["DOB"], ISO8601DateFormatterTransform(options: dateTimeOptions))
        departureDateTime <- map["DTDEPART"]
        diags <- map["DIAGS"]
        disposition <- map["UC"]
        heartRate <- map["HRATE"]
        height <- map["HT"]
        erRoom <- map["EREVNTRM"]
        eventDescription <- map["EREVNTDESC"]
        examDate <- (map["DT_DOCWTPT"], ISO8601DateFormatterTransform(options: dateTimeOptions))
        glucometer <- map["GLUCO"]
        language <- map["LANG"]
        medications <- map["MEDICATIONS"]
        moa <- map["MOA"]
        mrn <- map["MRN"]
        optrFirstname <- map["FN"]
        optrLastname <- map["LN"]
        patientClass <- map["PT_CLASS"]
        precautions <- map["PRECAUTION"]
        pointOfCare <- map["POC"]
        pulse <- map["PULSE"]
        pvid <- map["PVID"]
        respiration <- map["RESPIR"]
        rfv <- map["RFV"]
        room <- map["ROOM"]
        substances <- map["SUBSTANCES"]
        specialNeeds <- map["SPND"]
        temp <- map["TEMP"]
        triageDate <- (map["DT_TRIAGE"], ISO8601DateFormatterTransform(options: dateTimeOptions))
        vitalsDate <- (map["DT_VITALS"], ISO8601DateFormatterTransform(options: dateTimeOptions))
        weight <- map["WT"]
    }
    
//    open var patient           : Patient
//    var displayCC : String? {
//        get {
//            if let currentCC = cc, let abbreviation = ccAbbreviations[currentCC] {
//                return abbreviation
//            } else {
//                return cc
//            }
//        }
//    }
    
    var currentLengthOfStayMin : Int? {
        if let arrivalTime = self.arrivalDateTime, let departureTime = self.departureDateTime {
            return (Calendar.current as NSCalendar).components(.minute, from: arrivalTime, to: departureTime, options: []).minute
        }
        else if let arrivalTime = self.arrivalDateTime {
            return (Calendar.current as NSCalendar).components(.minute, from: arrivalTime, to: Date(), options: []).minute
        }
        return nil
    }
    
    var currentLengthOfStayHourMin : String? {
        if let arrivalTime = self.arrivalDateTime,  let departureTime = self.departureDateTime {
            let components = (Calendar.current as NSCalendar).components([.hour,.minute], from: arrivalTime, to: departureTime, options: [])
            return String(format:"%.2d:%.2d", components.hour!, components.minute!)
        }
        else if let arrivalTime = self.arrivalDateTime {
            let components = (Calendar.current as NSCalendar).components([.hour,.minute], from: arrivalTime, to: Date(), options: [])
            return String(format:"%.2d:%.2d", components.hour!, components.minute!)
        }
        
        return nil
    }
    
//    open var disposition       : PatientDisposition
//     var status            : String?
//     var interviewStatus   : String?
//     var ccAbbreviations = [String:String]()
//    
//     var vitalsTakenCount: Int {
//        get {
//            var count = 0
//            if height != nil { count = count + 1 }
//            if weight != nil { count = count + 1 }
//            if temp != nil { count = count + 1 }
//            if bpSys != nil { count = count + 1 }
//            if heartRate != nil { count = count + 1 }
//            if pulse != nil { count = count + 1 }
//            if respiration != nil { count = count + 1 }
//            if glucometer != nil { count = count + 1 }
//            if breathalyzer != nil { count = count + 1 }
//            return count
//        }
//    }
//    
//     var bloodPressure: String? {
//        if let sys = bpSys, let dia = bpDia {
//            return String(format:"%.2d/%.2d", sys, dia)
//        }
//        return nil
//    }
//    
//     var RFD : RequestForDischarge?
//     var assessmentResponses : [DynamicAssessmentResponse] = [DynamicAssessmentResponse]()
//     var moduleAlerts : [ModuleAlertResponse] = [ModuleAlertResponse]()
//    
//     func findAssessmentRespones ( _ assessmentId : Int ) -> [DynamicAssessmentResponse] {
//        var foundAssessments = [DynamicAssessmentResponse]()
//        for responseObject in self.assessmentResponses {
//            if let targetAssessmentId = responseObject.assessmentId {
//                if targetAssessmentId == assessmentId {
//                    foundAssessments.append(responseObject)
//                }
//            }
//        }
//        return foundAssessments
//    }
//    
//    func findModuleAlerts ( _ assessmentId : Int ) -> [ModuleAlertResponse] {
//        var foundAlerts = [ModuleAlertResponse]()
//        for responseObject in self.moduleAlerts {
//            if let targetAssessmentId = responseObject.assessmentId {
//                if targetAssessmentId == assessmentId {
//                    foundAlerts.append(responseObject)
//                }
//            }
//        }
//        return foundAlerts
//    }
//    
//    func isUrgent() -> Bool {
//        if let lastAlert = self.getLastestStatus() {
//            if lastAlert.status == 2 {
//                return true
//            }
//        }
//        return false
//    }
//    
//    
//    //get the status of the highest payloadId in the module alert array
//    func getLastestStatus() -> ModuleAlertResponse? {
//        let sortedArray = self.moduleAlerts.sorted { (first, second) -> Bool in
//            if let firstId = first.payloadId, let secondId = second.payloadId {
//                return firstId > secondId
//            }
//            return false
//        }
//        
//        if sortedArray.count > 0 {
//            return sortedArray[0]
//        }
//        
//        return nil
//    }
//    
//    var sepsisData : [SepsisDataPack] = [SepsisDataPack]()
//    

    public init(pvid: String) {
//        self.pvid = pvid
        self.disposition = PatientDisposition.unknown
    }

//    public init(pvid: String, patient: Patient) {
//        self.pvid = pvid
//        self.patient = patient
//        self.disposition = PatientDisposition.Unknown
//    }
}

public enum ModeOfArrival {
    case amb
    case pv
    case unknown
    case police
    case corrections
    case walkin
    case firerescue
    case fire
    
    public init (_ moaStr : String?) {
        if let moa = moaStr {
            if moa == "PV" || moa == "PC" || moa == "PRI VEHIC" || moa == "Private Vehicle" || moa == "CAR" {
                self = ModeOfArrival.pv
            } else if moa == "AMB" || moa == "Ambulance" || moa == "AMBBUT"{
                self = ModeOfArrival.amb
            } else if moa == "Corrections" {
                self = ModeOfArrival.corrections
            } else if moa == "Fire Rescue" {
                self = ModeOfArrival.firerescue
            } else if moa == "Fire" {
                self = ModeOfArrival.firerescue // changed from explict .fire value
            } else if moa == "Police" {
                self = ModeOfArrival.police
            } else if moa == "Walk in" {
                self = ModeOfArrival.walkin
            } else if moa.characters.count >= 3 && moa.substring(from: moa.characters.index(moa.startIndex, offsetBy: 3)) == "AMB" {
                self = ModeOfArrival.amb
            } else {
                self = ModeOfArrival.unknown
            }
        } else {
            self = ModeOfArrival.unknown
        }
    }
    
    public var JSONDescription: String {
        switch self {
        case .amb:
            return "AMB"
        case .pv:
            return "PV"
        case .unknown:
            return "UNK"
        case .police:
            return "Police"
        case .corrections:
            return "Corrections"
        case .walkin:
            return "Walk in"
        case .firerescue:
            return "Fire Rescue"
        case .fire:
            return "Fire"
        }
    }
    
    public var fullDescription : String {
        switch self {
        case .amb:
            return "Ambulance"
        case .pv:
            return "Private Vehicle"
        case .police:
            return "Police"
        case .firerescue:
            return "Fire Rescue"
        case .fire:
            return "Fire"
        case .walkin:
            return "Walk In"
        case .corrections:
            return "Corrections"
        default:
            return "Unknown"
        }
    }
    
    static public func allDescriptions() -> [String] {
        return [
            "Private Vehicle",
            "Walk in",
            "Ambulance",
            "Police",
            "Fire Rescue",
            "Corrections"]
    }
}

extension Date {
    func dateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}
