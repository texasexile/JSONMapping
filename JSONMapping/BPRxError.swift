//
//  BPRxError.swift
//  JSONMapping
//
//  Created by Ted Conley on 10/31/16.
//  Copyright © 2016 Ted Conley. All rights reserved.
//

import Foundation
import ReactiveSwift

enum BPRxError: String, Error {
    case login = "Authentication"
    case other = "Other"
    
    var description: String {
        return "\(rawValue) Error"
    }

    func bpMapError() {
        let (signal, observer) = Signal<String, NSError>.pipe()
        
        signal
            .mapError { (error: NSError) -> BPRxError in
                switch error.domain {
                case "com.example.foo":
                    return .login
                default:
                    return .other
                }
            }
            .observeFailed { error in
                print(error)
        }
        
        observer.send(error: NSError(domain: "com.example.foo", code: 42, userInfo: nil))    // prints "Foo Error"    }
    }
}


