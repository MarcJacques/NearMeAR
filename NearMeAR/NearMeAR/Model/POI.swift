//
//  POI.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/24/21.
//

import MapKit


struct POI {
    let currentLocation: CLLocation
    
    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    
    var areaOfInterest: [String] {
        self.placemark.areasOfInterest ?? [""]
    }
    
    var directions: Double {
        self.placemark.location?.course ?? Double()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var distanceFromPosition: Double {
        var totalDistance = 0.0
        if (self.placemark.location?.distance(from: currentLocation)) != nil {
            totalDistance = self.distanceFromPosition * 0.0006213171
        }
        return totalDistance
    }

}




