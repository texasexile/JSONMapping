//
//  API.swift
//  JSONMapping
//
//  Created by Ted Conley on 11/1/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public class API {
    static func login(withContext context: AppContext,
                      success loginSuccessObserver: Observer<LoginResponse, NoError>,
                      error loginErrorObserver: Observer<BPResponse, NoError>,
                      failure loginFailureObserver: Observer<Error, NoError>,
                      newPanda newPandaObserver: Observer<BPResponse, NoError>) {
        
        // create login request
        let urlString = ServerWebMethods.Login.makeNonAuthURLString(withContext: context)
        let url = URL(string: urlString)!
        let postDict = [
            "DeviceToken": context.staticDeviceToken! as String,
            "AppName": context.appName,
            "MACAddress": context.deviceId,
            "AppBundleId": context.bundleIdentifier! as String,
            "Username": context.userName ?? "",
            "AppVersion": context.appVersion,
            "Password": context.password ?? ""
        ] as [String : String]
        
        var urlRequest = try! url.makePostRequest(postDict)
        urlRequest.timeoutInterval = context.webServiceTimeout
        
        // log in
        let resultsSignalProducer = URLSession.shared.reactive.data(with: urlRequest)
            .observe(on: QueueScheduler())
        
        // process login result
        resultsSignalProducer.startWithResult { loginResult in
            switch loginResult {
            case .success:
                print("success")
                let data = loginResult.value!.0
                let jsonObject = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
                let bpResponse = BPResponse(JSON: jsonObject)
                
                switch bpResponse!.code! {
                case .success:
                    // success
                    loginSuccessObserver.send(value: bpResponse!.loginResponse!)
                    
                case .unknownFailure:
                    //error
                    loginErrorObserver.send(value: bpResponse!)
                    
                case .deviceNowRegistered:
                    newPandaObserver.send(value: bpResponse!)
                    
                default:
                    loginErrorObserver.send(value: bpResponse!)
                }
                
                break
                
            case .failure:
                print("failure")
                loginFailureObserver.send(value: loginResult.error!)
            }
        }
    }
    
    static func sync(withContext context: AppContext,
                     success syncSuccessObserver: Observer<SyncResponse, NoError>,
                     error loggedOutObserver: Observer<BPResponse, NoError>,
                     failure syncFailureObserver: Observer<Error, NoError>) {
        // create sync request
        let urlString = ServerWebMethods.Sync.makeAuthURLString(withContext: context, parameters: [String(context.lastPayloadID)])
        let url = URL(string: urlString)!
        
        var urlRequest = url.makeGetRequest()
        urlRequest.timeoutInterval = context.webServiceTimeout
        
        let syncSignalProducer = URLSession.shared.reactive.data(with: urlRequest)
        .observe(on: QueueScheduler())
        
        syncSignalProducer.startWithResult { syncResult in

            let start = Date()
            switch syncResult {
            case .success:
                let data = syncResult.value!.0
                let jsonObject = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
                let syncResponse = SyncResponse(JSON: jsonObject)
                let end = Date()
                let diff = end.timeIntervalSinceNow - start.timeIntervalSinceNow
                print("diff = \(diff)")
                
                switch syncResponse!.code! {
                case .success:
                    syncSuccessObserver.send(value: syncResponse!)
                    break
                    
                default:
                    let error = NSError.init(domain: "com.blupanda.jsonMapping", code: 0, userInfo: ["description" : "Don't know what happened"])
                    syncFailureObserver.send(value: error)
                    break
                }
                
                break
                
            case .failure:
                syncFailureObserver.send(value: syncResult.error!)
                break
            }
        }
    }
    
}

extension URL {
    func makePostRequest(_ postDictionary: [String: String]) throws -> URLRequest {
        var theRequest = URLRequest(url: self, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy)
        let writingOptions = JSONSerialization.WritingOptions()
        let postValueData = try JSONSerialization.data(withJSONObject: postDictionary, options: writingOptions)
        
        theRequest.setValue(String(describing: postValueData.count), forHTTPHeaderField:"Content-Length" )
        theRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = postValueData
        
        return theRequest as URLRequest
    }
    
    func makeGetRequest() -> URLRequest {
        var theRequest = URLRequest(url: self, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy)
        theRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
        theRequest.httpMethod = "GET"
        return theRequest
    }
}
