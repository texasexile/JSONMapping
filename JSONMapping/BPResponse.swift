//
//  BPResponse.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/31/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct BPResponse: Mappable {
    var dataKeyValuesFromJSON: String?
    var loginResponse: LoginResponse?
    var syncResponse: SyncResponse?
    var value: String?
    var code: ServerResultCode?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        dataKeyValuesFromJSON <- map["DataKeyValuesFromJSON"]
        loginResponse <- map["LoginResponse"]
        value <- map["Value"]
        code <- map["Code"]
    }
}
