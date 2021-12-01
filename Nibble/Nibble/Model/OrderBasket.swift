//
//  OrderBasket.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import Foundation

import Firebase

class OrderBasket: Identifiable {
    
    var id: String!
    var ownerId: String!
    var items: [Item] = []
    
    var total: Double {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0.0
        }
    }
    
    func add(_ item: Item) {
        items.append(item)
    }
    
    func remove(_ item: Item) {
        
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func emptyBasket() {
        self.items = []
        saveBasketToFirestore()
    }
    
    func saveBasketToFirestore() {
        
        FirebaseReference(collectionReference: .Basket).document(self.id).setData(basketDictionaryFrom(self))
    }
    
}


func basketDictionaryFrom(_ basket: OrderBasket) -> [String : Any] {
    
    var allItemIds: [String] = []
    
    for item in basket.items {
        allItemIds.append(item.id)
    }
    
    return NSDictionary(objects: [basket.id as Any,
                                  basket.ownerId as Any,
                                  allItemIds
                                ],
                    forKeys: [bID as NSCopying,
                     bOWNERID as NSCopying,
                     bITEMIDS as NSCopying
    ]) as! [String : Any]
    
}
