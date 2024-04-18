//
//  ForecastView.swift
//  Weather
//
//  Created by Dong on 2024/4/14.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var forecast: ForecastVM
    @State var showErrorAlert = false
    
    var body: some View {
        VStack {
            if forecast.loading {
                ProgressView()
            } else {
                Group {
                    currentWeather
                    SplineImage(url: getSplineURLWithImagePath(from: getImagePathFromWeatherType(from: forecast.currentWeatherType)))
                    fiveDayForecast
                }
            }
        }
        .padding()
        .onReceive(forecast.$error) { error in
            if error != nil {
                showErrorAlert.toggle()
            }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button(action: { showErrorAlert.toggle() }) {
                Text("OK")
            }
        } message: {
            Text(forecast.error?.localizedDescription ?? "")
        }
    }
    
    var currentWeather: some View {
        VStack {
            locationButton
            HStack {
                Text(getWeekdayText(from: forecast.weekday).uppercased())
                Text(forecast.currentRain)
            }
            .padding(.top, 12)
            Text(forecast.currentTemperature)
                .font(.system(size: 60))
                .fontWeight(.semibold)
        }
    }
    
    var fiveDayForecast: some View {
        HStack {
            ForEach(0..<5) { index in
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                            Image(getImagePathFromWeatherType(from: forecast.fiveDayWeatherType[index]))
                                .resizable()
                                .scaledToFit()
                        }
                    Text(getWeekdayText(from: (forecast.weekday + index) % 7 + 1))
                        .font(.system(size: 14, weight: .medium))
                        .padding(.bottom, 2)
                    Group {
                        Text(forecast.fiveDayTemperature[index])
                        Text(forecast.fiveDayRain[index])
                    }
                    .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, 40)
    }
    
    var locationButton: some View {
        Text(forecast.location.rawValue)
            .padding(8)
            .fontWeight(.medium)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray)
            }
    }
}

#Preview {
    ForecastView(forecast: ForecastVM())
}
