//
//  LocationWeather.swift
//  Weather
//
//  Created by Dong on 2024/4/14.
//

import Foundation

struct LocationWeather: Identifiable, Codable {
    
    var id: String { location }
    
    var location: String
    var rain: [Forecast]
    var temperature: [Forecast]
    var weatherType: [Forecast]
}

extension LocationWeather {
    
    static func decode(from data: Data) -> [LocationWeather] {
        do {
            let rootResponse = try JSONDecoder().decode(RootResponse.self, from: data)
            let locationsWeather = rootResponse.records.locations.flatMap { location in
                location.location.map { detail in
                    let rain = detail.weatherElement.filter { $0.elementName == "PoP12h" } .flatMap { $0.time }
                    let temperature = detail.weatherElement.filter { $0.elementName == "T" } .flatMap { $0.time }
                    let weatherType = detail.weatherElement.filter { $0.elementName == "Wx" } .flatMap { $0.time }
                    return LocationWeather(location: detail.locationName, rain: rain, temperature: temperature, weatherType: weatherType)
                }
            }
            return locationsWeather
        } catch {
            print(error)
            return []
        }
    }
    
    private struct RootResponse: Codable {
        let records: Records
    }
    
    private struct Records: Codable {
        let locations: [Location]
    }
    
    private struct Location: Codable {
        let location: [LocationDetail]
    }
    
    private struct LocationDetail: Codable {
        let locationName: String
        let weatherElement: [WeatherElement]
    }
    
    struct WeatherElement: Codable {
        let elementName: String
        let description: String
        let time: [Forecast]
    }
    
    struct Forecast: Codable {
        let startTime: String
        let endTime: String
        let elementValue: [ElementValue]
    }
    
    struct ElementValue: Codable {
        let value: String
        let measures: String
    }
}



