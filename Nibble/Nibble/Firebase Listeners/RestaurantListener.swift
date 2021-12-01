//
//  RestaurantListener.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/27/21.
//

import Foundation
import Firebase

class RestaurantListener: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    init () {
        downloadRestaurants()
    }
    
    func downloadRestaurants() {
        FirebaseReference(collectionReference: .RestaurantList).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            if !snapshot.isEmpty {
                self.restaurants = RestaurantListener.restaurantFromDictionary(snapshot)
            }
        }
    }
    
    static func restaurantFromDictionary(_ snapshot: QuerySnapshot) -> [Restaurant] {
        var allRestaurants: [Restaurant] = []
        for snapshot in snapshot.documents {
            let restaurantData = snapshot.data()
            allRestaurants.append(Restaurant(id: restaurantData[rID] as? String ?? UUID().uuidString, name: restaurantData[rNAME] as? String ?? "Unknown", category: restaurantData[rCATEGORY] as? String ?? "Unknown", imageName: restaurantData[rIMAGENAME] as? String ?? "unknown", description: restaurantData[rDESCRIPTION] as? String ?? "no description available", address: restaurantData[rADDRESS] as? String ?? "no location available", hours: restaurantData[rHOURS] as? String ?? "no hours available"))
        }
        return allRestaurants
    }
}
