//
//  APIError.swift
//  Weather
//
//  Created by Dong on 2024/4/15.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case invalidURL
    case responseError
    case invalidData
    case custom(String)
    case unknown(String)
    
    var description: String {
        switch self {
            case .invalidURL:
                "API endpoint isn't a valid URL."
            case .responseError:
                "API response status code unacceptable."
            case .invalidData:
                "API response data can't be decode into the given model."
            case .custom(let message):
                message
            case .unknown(let message):
                message
        }
    }
}
