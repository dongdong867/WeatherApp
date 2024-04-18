//
//  ContentView.swift
//  Weather
//
//  Created by Dong on 2024/4/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ForecastView(forecast: ForecastVM())
    }
}

#Preview {
    ContentView()
}
