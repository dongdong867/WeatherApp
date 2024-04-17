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
            VStack {
                VStack {
                    Text(forecast.location.rawValue)
                        .padding(8)
                        .fontWeight(.medium)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray)
                        }
                    HStack {
                        Text(getWeekdayText(from: forecast.weekday).uppercased())
                        Text("19%")
                    }
                    .padding(.top, 12)
                    Text(getTemperatureString(from: 23))
                        .font(.system(size: 60))
                        .fontWeight(.semibold)
                }
            }
            SplineImage(url: URL(string: "https://build.spline.design/YP4FfbiS1BsuZY6KKwcJ/scene.splineswift")!)
            HStack {
                ForEach(0..<5) { index in
                    VStack {
                        Image("sunny")
                            .resizable()
                            .scaledToFit()
                        Text(getWeekdayText(from: (forecast.weekday + index) % 7 + 1))
                            .font(.system(size: 14, weight: .medium))
                            .padding(.bottom, 2)
                        Group {
                            Text(getTemperatureString(from: 23))
                            Text("19%")
                        }
                        .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 40)
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
}

#Preview {
    ForecastView(forecast: ForecastVM())
}
