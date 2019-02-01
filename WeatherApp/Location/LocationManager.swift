//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Ernestas Kazinevicius on 01/02/2019.
//  Copyright © 2019 Ernestas Kazinevicius. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:            print("notDetermined")
            case .authorizedWhenInUse:      print("authorizedWhenInUse")
            case .authorizedAlways:         print("authorizedAlways")
            case .restricted:               print("restricted")
            case .denied:                   print("denied")
        }
    }
}
//TODO: FIX THE PERMISSIONS
