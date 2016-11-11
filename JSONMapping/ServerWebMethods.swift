//
//  ServerWebMethods.swift
//  BP_App_Framework
//
//  Created by BluPanda on 5/12/16.
//  Copyright © 2016 BluPanda. All rights reserved.
//

import Foundation

enum ServerWebMethods: String {
    case Login = "LOGIN"
    case Sync = "SYNC"
    case History = "HIST"
    case LoginComplete = "LOGINCOMPLETE"
    case UpdateVisit = "UPDATEVISIT"
    case Logout = "LOGOUT"
    case ConfirmSync = "CONFIRMPAYLOAD"
    case Ping = "PING"
    case AppState = "APPSTATE"
    case SinglePVIDSync = "PVID"
    case Unlock = "OKTOUNLOCK"
    case Assessments = "ASSESS"
    case AssessmentScores = "ASSESS/SCORES"
    case OpenDischarge = "DM/OPEN"
    case SetDischargeLOS = "DM/SETLOS"
    case EstimateDischargeLOS = "DM/ESTLOS"
    case SetDischargeRFD = "DM/SETRFD"
    case CancelDischarge = "DM/CANCELRFD"
    case StartDischarge = "DM/START"
    case ModuleVisitUpdate = "MODVISIT"
    case DeviceLog = "DEVICELOG"
    
    func makeNonAuthURLString(withContext context: AppContext) -> String {
        return "https://\(context.serverName!)/\(context.webServiceName)/\(self.rawValue)"
    }
    
    func makeNonAuthURLString(withContext context: AppContext,  parameters: [String]) -> String {
        var urlString = "https://\(context.serverName!)/\(context.webServiceName)/\(context.deviceId)/\(self.rawValue)"
        for param in parameters {
            urlString += "/\(param)"
        }
        return urlString
    }
    
    func makeAPIURLString(withContext context: AppContext,  parameters: [String]) -> String {
        var urlString = "https://\(context.serverName!)/\(context.webServiceName)/\(self.rawValue)"
        for param in parameters {
            urlString += "/\(param)"
        }
        return urlString
    }
    
    func makeAuthURLString(withContext context: AppContext,  parameters: [String]) -> String {
        var urlString = "https://\(context.serverName!)/\(context.webServiceName)/\(context.staticDeviceToken!)/\(self.rawValue)"
        for param in parameters {
            urlString += "/\(param)"
        }
        return urlString
    }
    
    func makeVisitUpdateURLString(withContext context: AppContext,  parameters: [String]) -> String {
        var urlString = "https://\(context.serverName!)/\(context.webServiceName)/\(self.rawValue)\(context.staticDeviceToken)"
        for param in parameters {
            urlString += "/\(param)"
        }
        return urlString
    }
}

enum UpdateVisitActions: String {
    case VisitAdd = "ADD"
    case VisitUpdate = "UPDATE"
    case AdmitRequest = "ARQ"
    case RemovePatient = "RP"
    case ViewStateUpdate = "VSU"
    case SpecialNeeds = "SPND"
    case Feedback = "FEEDBACK"
}
