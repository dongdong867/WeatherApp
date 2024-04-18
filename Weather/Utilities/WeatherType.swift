//
//  WeatherType.swift
//  Weather
//
//  Created by Dong on 2024/4/17.
//

import Foundation

func getImagePathFromWeatherType(from weatherType: Int) -> String {
    switch weatherType {
        case 1, 136, 137:
            return "sunny"
        case 2, 138, 139:
            return "mostlyClear"
        case 3, 4, 140...145:
            return "mostlyCloudy"
        case 5...7, 146...151:
            return "cloudy"
        case 8...41, 136...173, 178...193, 216...256, 321...335:
            return "rainy"
        case 42...82, 261...276, 290...320:
            return "thunderstorm"
        default:
            return "cloudyShowers"
    }
}


func getSplineURLWithImagePath(from path: String) -> URL {
    switch path {
        case "sunny":
            return URL(string: "https://build.spline.design/SQt280ZY2XnJh0db7Ocr/scene.splineswift")!
        case "mostlyClear":
            return URL(string: "https://build.spline.design/GxFUAv2PhGFGAj6kAK0v/scene.splineswift")!
        case "mostlyCloudy":
            return URL(string: "https://build.spline.design/uDHV8WIStT7IE6Gj-Y4e/scene.splineswift")!
        case "cloudy":
            return URL(string: "https://build.spline.design/njWe-guupZP7ZvrzqJBi/scene.splineswift")!
        case "rainy":
            return URL(string: "https://build.spline.design/yfZbiofiJDkwk9trlf9h/scene.splineswift")!
        case "thunderstorm":
            return URL(string: "https://build.spline.design/CafRlPWKr9cba8HuAB09/scene.splineswift")!
        default:
            return URL(string: "https://build.spline.design/YP4FfbiS1BsuZY6KKwcJ/scene.splineswift")!
    }
}
