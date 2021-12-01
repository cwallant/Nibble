//
//  Order.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import Foundation

class Order: Identifiable {
    
    var id: String!
    var customerId: String!
    var orderItems: [Item] = []
    var amount: Double!
    var customerName: String!
    var isCompleted: Bool!
    
    func saveOrderToFirestore() {
        
        FirebaseReference(collectionReference: .Order).document(self.id).setData(orderDictionaryFrom(self)) {
            error in
            
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
}


func orderDictionaryFrom(_ order: Order) -> [String : Any] {
    
    var allItemIds: [String] = []
    
    for item in order.orderItems {
        allItemIds.append(item.id)
    }
    
    return NSDictionary(objects: [order.id as Any,
                                  order.customerId as Any,
                                  allItemIds as Any,
                                  order.amount as Any,
                                  order.customerName as Any,
                                  order.isCompleted as Any
                                ],
                        forKeys: [oID as NSCopying,
                                  oCUSTOMERID as NSCopying,
                                  oITEMIDS as NSCopying,
                                  oAMOUNT as NSCopying,
                                  oCUSTOMERNAME as NSCopying,
                                  oISCOMPLETED as NSCopying
    ]) as! [String : Any]
}
