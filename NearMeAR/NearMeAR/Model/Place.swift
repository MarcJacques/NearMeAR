//
//  Place.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/25/21.
//

import Foundation


struct Place: Codable {
    let name: String
    let address1: String
    let city: String
    let state: String
    let country: String
    
    var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "name", value: self.name),
                URLQueryItem(name: "address1", value: self.address1),
                URLQueryItem(name: "city", value: self.city),
                URLQueryItem(name: "state", value: self.state),
                URLQueryItem(name: "country", value: self.country)]
    }
}

struct PointOfInterest: Codable {
    let id: String
    let name: String
    let isClosed: Bool
    let displayPhone: String
    let rating: Double
    let location: Address
    let coordinates: Coordinates
    let price: String
    let photos: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isClosed = "is_closed"
        case displayPhone = "display_phone"
        case rating
        case location
        case coordinates
        case price
        case photos
    }
    struct Coordinates: Codable {
        let latitude: Double
        let longitude: Double
    }
    
}

struct Address: Codable {
    let displayAddress: [String]
    
    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}

struct Reviews: Codable {
    let reviews: [Review]
}

struct Review: Codable {
    //        let name: String
    let rating: Int
    let text: String
}



struct BusinessList: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    var id: String
    var name: String
}

