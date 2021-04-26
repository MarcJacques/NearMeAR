//
//  Place.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/25/21.
//

import Foundation

struct Place: Codable {
    let id: String
    let name: String
    let rating: Int
    let photos: [Photo]
    let location: Location
    let reviews: [Review]?
}

struct Photo: Codable {
    let photoURL: String
}

struct Location: Codable {
    let address1: String
    let city: String
    let state: String
    let displayAddress: [Address]
    
}

struct Address: Codable {
    let address: String
}

struct Review: Codable {
    let text: String
    let rating: Int
    let name: String
}

extension Location {
    enum CodingKeys: String, CodingKey {
        case address1
        case city
        case state
        case displayAddress = "display_address"
    }
}

