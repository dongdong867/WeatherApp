//
//  Temperature.swift
//  Weather
//
//  Created by Dong on 2024/4/17.
//

import Foundation

func getTemperatureString(from temperature: Double) -> String {
    let temperature = Measurement(value: temperature, unit: UnitTemperature.celsius)
    let formatter = MeasurementFormatter()
    formatter.numberFormatter.maximumFractionDigits = 0 // Optional: Set the number of decimal places
    
    return formatter.string(from: temperature)
}
