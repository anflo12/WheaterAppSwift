//
//  LocationViewModel.swift
//  WheaterApp
//
//  Created by Andrés Flórez on 17/01/22.
//

import Foundation

import CoreLocation

struct Location {
    let lat:Double
    let lon:Double
}
final class LocationViewModel: NSObject,ObservableObject {
    private let locationManager: CLLocationManager = .init()
    @Published var coords:Location = .init(lat: 0.0 , lon: 0.0)
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
         
        self.coords = .init(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        
    }
}
