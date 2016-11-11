//
//  AppContext.swift
//  BluPhysician
//
//  Created by Ted Conley on 8/12/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import UIKit

open class AppContext {
    var appName: String!
    var autoLogin: String?
    var autoPassword: String?
    var avScreeningName: String?
    var ccAbbreviationsName: String?
    var cleanDocumentsOnStart: Bool?
    var databaseName: String?
    var enablePush: Bool?
    var etohScreeningName: String?
    var homicideScreeningName: String?
    var lastPayloadID = 0
    var password: String?
    var pocTestScreeningName: String?
    var sendLoginConfirmation: Bool?
    var serverName: String?
    var serviceName: String?
    var staticDeviceToken: String?
    var sucideScreeningName: String?
    var syncInterval: Double?
    var userName: String?
    var webServiceTimeout = 0.0
    var deviceId: String {
        get {
            if AppContext.isSimulator {
                return "11:AA:22:BB:33:CC"
            } else {
                return UIDevice.current.identifierForVendor!.uuidString
            }
        }
    }
    var appVersion: String {
        get {
            if let ver = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                return ver
            } else {
                return "unknown"
            }
        }
    }
    let bundleIdentifier = Bundle.main.bundleIdentifier
    let webServiceName = "PandaWS.svc/PWS"
    
    static let sharedInstance = AppContext()
    
    //MARK: - Initialization
    func initialize (_ plistFileName: String) {
        if let path = Bundle.main.path(forResource: plistFileName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            appName               = dict["AppName"] as? String
            autoLogin             = dict["AutoLogin"] as? String
            autoPassword          = dict["AutoPassword"] as? String
            avScreeningName       = dict["AVScreeningName"] as? String
            ccAbbreviationsName   = dict["CCAbbreviation"] as? String
            cleanDocumentsOnStart = dict["CleanDocumentsOnStart"] as? Bool
            databaseName          = dict["DatabaseName"] as? String
            enablePush            = dict["EnablePush"] as? Bool
            etohScreeningName     = dict["ETOHScreeningName"] as? String
            homicideScreeningName = dict["HomicideScreeningName"] as? String
            pocTestScreeningName  = dict["POCTestScreeningName"] as? String
            sendLoginConfirmation = dict["SendLoginConfirmation"] as? Bool
            serverName            = dict["ServerName"] as? String
            serviceName           = dict["ServiceName"] as? String
            staticDeviceToken     = dict["StaticDeviceToken"] as? String
            sucideScreeningName   = dict["SucideScreeningName"] as? String
            syncInterval          = dict["SyncInterval"] as? Double
            webServiceTimeout     = dict["WebServiceTimeout"] as! Double
        }
    }
    
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
    
    static let usePushNotification: Bool = {
        return AppContext.sharedInstance.enablePush!
            && isSimulator == false
    }()
    
    static let autoLogin: Bool = {
        if AppContext.sharedInstance.autoLogin != nil {
            if AppContext.sharedInstance.autoLogin!.characters.count > 0 {
                return true
            }
        }
        return false
    }()

}

//fileprivate var webServiceName = "PandaWS.svc/PWS"
//fileprivate var apiServiceName = "PandaAPI.svc/API"
//fileprivate let logger = FrameworkLogger.sharedInstance
//fileprivate var certificateChain: Data?
//fileprivate var userName: String?
//fileprivate var password: String?
//fileprivate var serverAddress: String?
//fileprivate var deviceToken: String?
//fileprivate var deviceId: String?
//fileprivate var appName: String?
//fileprivate var appVersion: String?
//fileprivate var appBundleId: String?
//fileprivate var loginConfirmationEnabled: Bool = true
//fileprivate var syncConfirmationEnabled: Bool = true
//fileprivate var webServiceTimeout: TimeInterval = 60.0
//fileprivate var lastPayloadID: Int
//open var connectionStatus = ConnectionStatus.unconnected
//open static let sharedInstance = WebService()
//
//
//fileprivate func setFrameworkSettings(_ appConfig: AppConfig, framework: BluAppFramework ) {
//    framework.enableLogging(true)
//    framework.setAppName(appConfig.appName!)
//    framework.setAppVersion((Bundle.main.infoDictionary?["CFBundleVersion"] as? String)!)
//    framework.setAppBundleId(Bundle.main.bundleIdentifier!)
//    framework.setServerAddress(appConfig.serverName!)
//    framework.enableLoginConfirmation(appConfig.sendLoginConfirmation!)
//    framework.enableConsoleLogging(true)
//    
//    if !AppConfig.usePushNotification {
//        framework.setDeviceToken(appConfig.staticDeviceToken!)
//    }
//}

