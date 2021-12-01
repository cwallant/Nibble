//
//  BasketListener.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import Foundation

import Firebase

class BasketListener: ObservableObject {
    
    @Published var orderBasket: OrderBasket!
    
    
    init() {
        downloadBasket()
    }
    
    func downloadBasket() {
        
        if FUser.currentUser() != nil {
            FirebaseReference(collectionReference: .Basket).whereField(bOWNERID, isEqualTo: FUser.currentId()).addSnapshotListener { (snapshot, error) in
                
                
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty {
                    
                    let basketData = snapshot.documents.first!.data()
                    
                    getDrinksFromFirestore(withIds: basketData[bITEMIDS] as? [String] ?? []) { (allItems) in
                        
                        let basket = OrderBasket()
                        basket.ownerId = basketData[bOWNERID] as? String
                        basket.id = basketData[kID] as? String
                        basket.items = allItems
                        self.orderBasket = basket
                    }
                }
            }

        }
    }
}


func getDrinksFromFirestore(withIds: [String], completion: @escaping (_ itemArray: [Item]) -> Void) {
    
    var count = 0
    var itemArray: [Item] = []
    
    
    if withIds.count == 0 {
        completion(itemArray)
        return
    }
    
    for itemId in withIds {
        
        FirebaseReference(collectionReference: .Menu).whereField(iID, isEqualTo: itemId).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                let itemData = snapshot.documents.first!
                
                itemArray.append(Item(id: itemData[iID] as? String ?? UUID().uuidString,
                                      restaurant: itemData[iRESTAURANT] as? String ?? "Unknown",
                                      name: itemData[iNAME] as? String ?? "Unknown",
                                      imageName: itemData[iIMAGENAME] as? String ?? "Unknown",
                                      category: Category(rawValue: itemData[iCATEGORY] as? String ?? "Food") ?? .food,
                                      description: itemData[iDESCRIPTION] as? String ?? "No Description Available",
                                      price: itemData[iPRICE] as? Double ?? 0.00,
                                      numberAvailable: itemData[iNUMBERAVAILABLE] as? Int ?? 0))
                
                count += 1
                
            } else {
                print("have no drink")
                completion(itemArray)
            }
            
            
            if count == withIds.count {
                completion(itemArray)
            }
            
        }

    }
    
    
    
}
