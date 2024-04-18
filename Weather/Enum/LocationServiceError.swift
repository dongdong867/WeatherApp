//
//  LocationServiceError.swift
//  Weather
//
//  Created by Dong on 2024/4/16.
//

import Foundation

enum LocationServiceError: Error, CustomStringConvertible {
    case noAuthorization
    case unknownAuthorization
    case locationUnknown
    case geocodingFailed
    case notInTaiwan
    case unknownError(Error?)
    
    var description: String {
        switch self {
            case .noAuthorization:
                "Location authorization denied."
            case .unknownAuthorization:
                "Unknown error when authorization."
            case .locationUnknown:
                "Location result not found."
            case .geocodingFailed:
                "Failed to reverse geocode."
            case .notInTaiwan:
                "Location city not supported."
            case .unknownError(let error):
                String(describing: error)
        }
    }
}
