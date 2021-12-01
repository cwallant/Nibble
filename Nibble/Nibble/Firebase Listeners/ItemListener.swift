//
//  ItemListener.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 12/1/21.
//

import Foundation
import Firebase

class ItemListener: ObservableObject {
    @Published var items: [Item] = []
    init () {
        downloadItems()
    }
    
    func downloadItems() {
        FirebaseReference(collectionReference: .Menu).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            if !snapshot.isEmpty {
                self.items = ItemListener.itemFromDictionary(snapshot)
            }
        }
    }
    
    static func itemFromDictionary(_ snapshot: QuerySnapshot) -> [Item] {
        var allItems: [Item] = []
        for snapshot in snapshot.documents {
            let itemData = snapshot.data()
            allItems.append(Item(id: itemData[iID] as? String ?? UUID().uuidString, restaurant: itemData[iRESTAURANT] as? String ?? "Unknown", name: itemData[iNAME] as? String ?? "Unknown", imageName: itemData[iIMAGENAME] as? String ?? "unknown", category: itemData[iCATEGORY] as? Category ?? .food, description: itemData[iDESCRIPTION] as? String ?? "no description available", price: itemData[iPRICE] as? Double ?? 0.00, numberAvailable: itemData[iNUMBERAVAILABLE] as? Int ?? 0))
        }
        return allItems
    }
}
