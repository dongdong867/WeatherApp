//
//  ForecastVM.swift
//  Weather
//
//  Created by Dong on 2024/4/15.
//

import Foundation

final class ForecastVM: ObservableObject {
    @Published var location: Location = .tpe
    @Published var weekday = getTodayWeekday()
    @Published var loading = true
    @Published var error: Error?

    @Published var currentRain = ""
    @Published var currentTemperature = ""
    @Published var currentWeatherType = -1
    @Published var fiveDayRain: [String] = []
    @Published var fiveDayTemperature: [String] = []
    @Published var fiveDayWeatherType: [Int] = []
    
    
    init () {
        self.loadLocation()
        self.loadForecast()
    }
    
    func loadLocation() {
        let lastSelectedLocation = UserDefaults.standard.string(forKey: "lastSelectedLocation")
        if lastSelectedLocation != nil {
            location = Location(rawValue: lastSelectedLocation!) ?? .tpe
        }
    }
    
    func loadForecast() {
        Task {
            await fetchForecast()
        }
    }
    
    func handleLocationSelected() {
        loading.toggle()
        UserDefaults.standard.setValue(location.rawValue, forKey: "lastSelectedLocation")
        loadForecast()
    }
    
    @MainActor
    func getCurrentLocation() {
        do {
            let locationService = LocationService()
            try locationService.requestLocation()
            locationService.decodeCityFromGeocode { status in
                switch status {
                    case .success(let cityCode):
                        guard let location = Location.from(string: cityCode.lowercased())
                        else {
                            self.error = LocationServiceError.notInTaiwan
                            return
                        }
                        print(location.rawValue)
                        self.location = location
                    case .failure(let error):
                        self.error = error
                }
            }
        } catch {
            self.error = error
        }
    }
    
    
    @MainActor
    private func fetchForecast() async {
        do {
            let authorizationToken = Bundle.main.infoDictionary?["AUTHORIZATION_TOKEN"] as? String
            let apiEndpointText = "https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=\(authorizationToken ?? "")&locationName=\(location.rawValue)&elementName=PoP12h,T,Wx"
            
            guard let apiEndpoint = URL(string: apiEndpointText)
            else { throw APIError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: apiEndpoint)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
             guard let locationWeather = try LocationWeather.decode(from: data)
            else { throw APIError.custom("Response data is empty.") }
            
            self.currentRain = locationWeather.getCurrentRain()
            self.currentTemperature = locationWeather.getCurrentTemperature()
            self.currentWeatherType = locationWeather.getCurrentWeatherType()
            self.fiveDayRain = locationWeather.getFiveDayRain()
            self.fiveDayTemperature = locationWeather.getFiveDayTemperature()
            self.fiveDayWeatherType = locationWeather.getFiveDayWeatherType()
            
            self.loading = false
        } catch {
            self.error = error
        }
    }
}
