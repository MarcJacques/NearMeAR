//
//  ContentView.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/24/21.
//

import SwiftUI
import MapKit

struct ContentView : View {
    @ObservedObject var locationManager = LocationManager()
  
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            ARViewContainer()
            
            Text("\(locationManager.locationString) ")
                .font(.largeTitle)
                .foregroundColor(Color.white)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
