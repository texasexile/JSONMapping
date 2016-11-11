//
//  MOATransform.swift
//  JSONMapping
//
//  Created by Ted Conley on 11/2/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import  ObjectMapper

open class MOATransform: TransformType {
    public typealias Object = ModeOfArrival
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> ModeOfArrival? {
        return ModeOfArrival.init(value as! String?)
    }
    
    open func transformToJSON(_ value: ModeOfArrival?) -> String? {
        return value?.JSONDescription
    }
}
