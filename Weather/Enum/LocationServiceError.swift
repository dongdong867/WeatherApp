//
//  LocationServiceError.swift
//  Weather
//
//  Created by Dong on 2024/4/16.
//

import Foundation

enum LocationServiceError: Error {
    case noAuthorization
    case unknownAuthorization
    case locationUnknown
    case geocodingFailed
    case networkError
    case notInTaiwan
    case unknownError(Error?)
}
