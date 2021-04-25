//
//  SearchButtonBar.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/24/21.
//

import SwiftUI

struct SearchButtonBar: View {
    
    var body: some View {
    
        HStack {
            RestaurantSearchButton()
            
            Spacer()
            
            ShoppingSearchButton()
            
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    
    }
    
}

struct RestaurantSearchButton: View {
    let restaurantIcon = "cutlery"
    
    var body: some View {
        VStack {
                         
                SearchButton(searchTerm: "restaurant", buttonImageName: restaurantIcon)
                
            }
        }
    }


struct ShoppingSearchButton: View {
    let shoppingIcon = "shoppingBag"
    
    var body: some View {
        VStack {

                SearchButton(searchTerm: "shopping", buttonImageName: shoppingIcon)
                
            }
        }
    }


struct SearchButton: View {
    
    let searchTerm: String
    let buttonImageName: String
    var locationManager = LocationManager()
    
    var body: some View {
        
        Button(action: {
            locationManager.findPOI(searchTerm: searchTerm)
        }) {
            Image(buttonImageName)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
                .frame(width: 50, height: 50)
        }
    }
}
