//
//  LocationService.swift
//  Weather
//
//  Created by Dong on 2024/4/16.
//

import CoreLocation
import CoreLocationUI
import Foundation

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var location: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            switch clErr.code {
                case CLError.locationUnknown:
                    print("Location is currently unknown, but CL will keep trying.")
                case CLError.denied:
                    print("Access to location or ranging has been denied by the user.")
                default:
                    print("Other Core Location error:", clErr.localizedDescription)
            }
        } else {
            print("Other error:", error.localizedDescription)
        }
    }
    
    func requestLocation() throws {
        switch self.manager.authorizationStatus {
            case .notDetermined:
                self.manager.requestWhenInUseAuthorization()
                try requestLocation()
                break
            case .restricted, .denied:
                throw LocationServiceError.noAuthorization
            case .authorizedAlways, .authorizedWhenInUse:
                self.manager.requestLocation()
                break
            @unknown default:
                throw LocationServiceError.unknownAuthorization
        }
    }
    
    func decodeCityFromGeocode(completion: @escaping (Result<String, LocationServiceError>) -> Void) {
        let geocoder = CLGeocoder()
        
        guard let location = manager.location
        else {
            completion(.failure(LocationServiceError.locationUnknown))
            return
        }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil
            else {
                completion(.failure(LocationServiceError.geocodingFailed))
                return
            }
            
            guard let placemark = placemarks?.first
            else {
                completion(.failure(LocationServiceError.locationUnknown))
                return
            }
            
            guard placemark.locality != nil
            else {
                completion(.failure(LocationServiceError.locationUnknown))
                return
            }
            
            completion(.success(placemark.administrativeArea!))
        }
    }
}
