//
//  DateYearTransform.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/28/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import  ObjectMapper

open class DateYearTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    let dateFormatter = { () -> DateFormatter in 
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-mm-dd"
        return formatter
    }()
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return dateFormatter.date(from: dateString)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
