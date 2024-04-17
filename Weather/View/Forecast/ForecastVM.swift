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
    @Published var locationWeather: LocationWeather?
    @Published var error: Error?
    
    
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
    
    
    @MainActor
    private func fetchForecast() async {
        do {
            let authorizationToken = Bundle.main.infoDictionary?["AUTHORIZATION_TOKEN"] as? String
            let apiEndpointText = "https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=\(authorizationToken ?? "")&locationName=\(location.rawValue)&elementName=PoP12h,T,Wx"
            print(apiEndpointText)
            
            guard let apiEndpoint = URL(string: apiEndpointText)
            else { throw APIError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: apiEndpoint)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            self.locationWeather = try LocationWeather.decode(from: data)
        } catch {
            self.error = error
        }
    }
}
