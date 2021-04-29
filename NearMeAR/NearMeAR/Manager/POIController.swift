//
//  POIController.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/25/21.
//

import Foundation

class POIController {
       //
    //let baseURL = URL(string: "https://api.yelp.com/v3/businesses/")!
    ////let baseURL = "https://api.yelp.com/v3/businesses/"
    let session = URLSession(configuration: .default)
    var components = URLComponents(string: "https://api.yelp.com/v3/businesses/")!
    let bearer = "x-2bgd1jRbajaM_rbZHhN50ht25FgohvBiJeGKNx3rFwR-1tT5vOUOdhYsBS9gUR5rZItYvmKyRLo2CbpRDMJOWZa1WaIyU4aD3Esejn6kbPCcGz2yrpel54PrSFYHYx"

    
    func fetchBusinessData(place: Place) {
        components.path = "matches"
        components.queryItems = place.queryItems
        
        let matchURL = components.url!
        
        var request = URLRequest(url: matchURL)
        request.addValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        
        session.dataTask(with: request) { data, _, error in
            guard let data = data else { fatalError() }
            //        print(response)
            
            do {
                let newBusiness = try JSONDecoder().decode(BusinessList.self, from: data).businesses.first ?? Business(id: "", name: "")
                print("DEBUG: \(newBusiness.name)")
                //            business = newBusiness.businesses?.first
                //            businessDetails.append(newBusiness)
                let reviews = self.getReviews(business: newBusiness)
                let photos = self.getImages(business: newBusiness)
                
            } catch {
                print(error)
            }
            
        }.resume()
        
        //    businesses.append(business)
    }

    private func getReviews(business: Business) -> [Review] {
        var reviews: [Review] = []
        components.path = "\(business.id)/reviews"
        
        var request = URLRequest(url: components.url!)
        request.addValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else { fatalError() }
            //        print("Debug \(String(describing: response))")
            
            do {
                reviews = try JSONDecoder().decode(Reviews.self, from: data).reviews
//                print("Debug: \(String(describing: reviews.first?.text))")
            } catch {
                print(error)
            }
        }.resume()
        return reviews
    }

    private func getImages(business: Business) -> [String] {
        var photos: [String] = []
        
        var request = URLRequest(url: components.url!)
        request.addValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else { fatalError() }
            //        print("Debug \(String(describing: response))")
            
            do {
                photos = try JSONDecoder().decode(PointOfInterest.self, from: data).photos
//                print("Debug: \(String(describing: point.photos.first))")
            } catch {
                print(error)
            }
        }.resume()
        return photos
    }

}
