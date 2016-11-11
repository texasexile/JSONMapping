//
//  Room.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ObjectMapper

struct Room: Mappable {
    var roomName: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        roomName <- map["RoomName"]
    }
}
