//
//  FirebaseReference.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/24/21.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Menu
    case Order
    case Basket
    case RestaurantList
}

func FirebaseReference(collectionReference:FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
