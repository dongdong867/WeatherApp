//
//  Weekday.swift
//  Weather
//
//  Created by Dong on 2024/4/17.
//

import Foundation

func getTodayWeekday() -> Int {
    return Calendar.current.component(.weekday, from: Date())
}

func getWeekdayText(from weekday: Int) -> String {
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    return weekdays[weekday - 1]
}
