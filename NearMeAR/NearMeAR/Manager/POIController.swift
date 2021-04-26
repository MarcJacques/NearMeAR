//
//  POIController.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/25/21.
//

import Foundation

enum NetworkError: Error {
    case otherError(Error)
    case noData
    case decodeFailed
}

class POIController {
    
    var points: [POI] = []
    
    private var baseURL = URL(string: "https://api.yelp.com/v3/businesses")!
    private let bearer = "x-2bgd1jRbajaM_rbZHhN50ht25FgohvBiJeGKNx3rFwR-1tT5vOUOdhYsBS9gUR5rZItYvmKyRLo2CbpRDMJOWZa1WaIyU4aD3Esejn6kbPCcGz2yrpel54PrSFYHYx"
    
    func getPOIData(_ place: Place, completion: @escaping (Result<POI, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent("search")
              
        var request = URLRequest(url: url)
        request.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else { return }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let point = try JSONDecoder().decode(place.self, from: data)
            }
        }
        task.resume()
    }
    
    
    func getImage() {
        let imageURL = baseURL
    }
    
    func getReviews(place: Place) {
        let url = baseURL.appendPathComponent("\(place.id)")
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
    }
    
}
