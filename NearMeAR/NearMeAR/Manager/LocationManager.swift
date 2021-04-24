//
//  LocationManager.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/24/21.
//

import MapKit

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var degrees: Double = .zero
    @Published var currentLocation: CLLocation? = nil
    
    private(set) var locationString: String = ""
    private var hasSomeKindOfPermission: Bool
    private var gettingExactLocation: Bool
    
    
    override init() {
        self.hasSomeKindOfPermission = false
        self.gettingExactLocation = false
        
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.activityType = .otherNavigation
        
        self.deviceOrientation()
    }
    
    
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.hasSomeKindOfPermission = true
        case .notDetermined, .denied, .restricted:
            self.hasSomeKindOfPermission = false
        default: print("unhandled case")
            
        }
        
        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            self.gettingExactLocation = false
        case .fullAccuracy:
            self.gettingExactLocation = true
        default: print("This shouldn't happen")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        currentLocation = location
        lookUpCurrentLocation { _ in print("DEBUG: Updating location String") }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        degrees = newHeading.magneticHeading
    }
    
    func deviceOrientation() {
        if CLLocationManager.headingAvailable() {
            locationManager.startUpdatingHeading()
        }
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                                -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.currentLocation {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    if let city = firstLocation?.locality,
                                                       let state = firstLocation?.administrativeArea {
                                                        self.locationString = city + ", " + state
                                                    }
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
                                            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
}

