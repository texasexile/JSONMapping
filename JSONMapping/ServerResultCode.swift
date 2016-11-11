//
//  ResultCodes.swift
//  BP_App_Framework
//
//  Created by BluPanda on 5/11/16.
//  Copyright © 2016 BluPanda. All rights reserved.
//

import Foundation

enum ServerResultCode : Int {
    case success = 1000
    case passwordUpdateRequired = 1010
    case deviceNowRegistered = 1020
    case unknownFailure = 2000
    case missingData = 2040
    case failureValidatingUserName = 2010
    case failureValidatingHandheld = 2020
    case failureAppUpdateRequired = 2002
    case failureRegisteringNewPanda = 2025
    case failureRegisteringHandheldNameExists = 2023
    case failureRegisteringHandheldMACExists = 2024
    case processItemFailureEmptyThreshold = 4021
    case admitProcessFailureInsertingRequest = 4210
    case admitProcessFailureInsertingResponse = 4220
    case admitProcessFailureRequestDoesNotExist = 4230
    case notImplemented = 9000
    case clientException = 20000
}
