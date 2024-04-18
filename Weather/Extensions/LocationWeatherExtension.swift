//
//  LocationWeather.swift
//  Weather
//
//  Created by Dong on 2024/4/18.
//

import Foundation

extension LocationWeather {
    
    func getCurrentRain() -> String {
        guard !rain.isEmpty,
              !rain[0].elementValue.isEmpty,
              let rainPercentage = Int(rain[0].elementValue[0].value)
        else { return "-" }
        
        return "\(rainPercentage)%"
    }
    
    func getCurrentTemperature() -> String {
        guard !temperature.isEmpty,
              !temperature[0].elementValue.isEmpty,
              let currentTemperature = Double(temperature[0].elementValue[0].value)
        else { return "-" }
        
        return getTemperatureString(from: currentTemperature)
    }
    
    func getCurrentWeatherType() -> Int {
        guard !weatherType.isEmpty,
              !weatherType[0].elementValue.isEmpty,
              let currentWeatherType = Int(weatherType[0].elementValue[1].value)
        else { return -1 }
        
        return currentWeatherType
    }
    
    func getFiveDayRain() -> [String] {
        guard !rain.isEmpty
        else { return Array(repeating: "-", count: 5) }
        
        var rainForecasts: [String] = []
        for index in 1...5 {
            if !rain[index*2].elementValue.isEmpty,
               !rain[index*2+1].elementValue.isEmpty,
               let firstForecast = Int(rain[index*2].elementValue[0].value),
               let secondForecast = Int(rain[index*2+1].elementValue[0].value){
                rainForecasts.append("\((firstForecast+secondForecast)/2)%")
            } else {
                rainForecasts.append("-")
            }
        }
        
        return rainForecasts
    }
    
    func getFiveDayTemperature() -> [String] {
        guard !temperature.isEmpty
        else { return Array(repeating: "-", count: 5) }
        
        var temperatureForecasts: [String] = []
        for index in 1...5 {
            if !temperature[index*2].elementValue.isEmpty,
               !temperature[index*2+1].elementValue.isEmpty,
               let firstForecast = Double(temperature[index*2].elementValue[0].value),
               let secondForecast = Double(temperature[index*2+1].elementValue[0].value) {
                temperatureForecasts.append(getTemperatureString(from: (firstForecast+secondForecast)/2))
            } else {
                temperatureForecasts.append("-")
            }
        }
        
        return temperatureForecasts
    }
    
    func getFiveDayWeatherType() -> [Int] {
        guard !weatherType.isEmpty
        else { return Array(repeating: -1, count: 5) }
        
        var weatherTypeForecasts: [Int] = []
        for index in 1...5 {
            if !weatherType[index*2].elementValue.isEmpty,
               let forecast = Int(weatherType[index*2].elementValue[1].value) {
                weatherTypeForecasts.append(forecast)
            } else {
                weatherTypeForecasts.append(-1)
            }
        }
        
        return weatherTypeForecasts
    }
}
