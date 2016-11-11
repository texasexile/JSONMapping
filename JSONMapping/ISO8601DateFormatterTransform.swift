//
//  ISO8601DateFormatterTransform.swift
//  JSONMapping
//
//  Created by Ted Conley on 11/3/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import  ObjectMapper

open class ISO8601DateFormatterTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    private let dateFormatter = ISO8601DateFormatter()
    
    public init(options optionSet: ISO8601DateFormatter.Options) {
        dateFormatter.formatOptions = optionSet
    }
    
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
