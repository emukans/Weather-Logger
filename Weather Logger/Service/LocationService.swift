//
//  LocationService.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 12/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import CoreLocation
import RxCocoa

class LocationService: NSObject, CLLocationManagerDelegate
{

    // MARK: - Properties
    
    let locationManager: CLLocationManager
    var isLocationServiceEnabled = true
    let lastUpdatedLocation = BehaviorRelay<CLLocation?>(value: nil)

    
    // MARK: - Initialization
    
    static var shared: LocationService {
        get {
            return LocationService()
        }
    }
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            self.isLocationServiceEnabled = false
        }
        
        self.locationManager.delegate = self
    }
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last, newLocation.horizontalAccuracy >= 0.0
            && newLocation.timestamp.timeIntervalSinceNow > -60.0
            && !(newLocation.coordinate.latitude == 0.0 || newLocation.coordinate.longitude == 0.0)
            else {
                return
        }
        
        self.lastUpdatedLocation.accept(newLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        
        self.lastUpdatedLocation.accept(nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let enabled: Bool
        
        switch status {
        case .authorizedAlways:
            enabled = true
        case .authorizedWhenInUse:
            enabled = true
        default:
            enabled = false
        }
        
        self.isLocationServiceEnabled = enabled
        
        if self.isLocationServiceEnabled {
            self.locationManager.startUpdatingLocation()
        }
    }

}
