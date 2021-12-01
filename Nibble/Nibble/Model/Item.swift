//
//  Item.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/24/21.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable, Hashable {
    case food
    case drink
    case dessert
}

struct Item: Identifiable, Hashable {
    var id: String
    var restaurant: String
    var name: String
    var imageName: String
    var category: Category
    var description: String
    var price: Double
    var numberAvailable: Int
}

func itemDictionaryFrom(item:Item) -> [String : Any] {
    
    
    return NSDictionary(objects: [item.id,
                                  item.name,
                                  item.imageName,
                                  item.category.rawValue,
                                  item.description,
                                  item.price,
                                  item.numberAvailable],
                        forKeys: [
                                  iID as NSCopying,
                                  iNAME as NSCopying,
                                  iIMAGENAME as NSCopying,
                                  iCATEGORY as NSCopying,
                                  iDESCRIPTION as NSCopying,
                                  iPRICE as NSCopying,
                                  iNUMBERAVAILABLE as NSCopying]
    ) as! [String : Any]
}

func createMenu() {
    for item in itemData {
        FirebaseReference(collectionReference: .Menu).addDocument(data: itemDictionaryFrom(item: item))
    }
}

let itemData = [
    // Olives
    Item(id: UUID().uuidString, restaurant: "Olives", name: "#6 Burrito", imageName: "6burrito", category: Category.food, description: "BBB (Best Breakfast Burrito) - bacon, egg, and cheese on a white tortilla wrap with avocado and salsa verde", price: 1.50, numberAvailable: 10),
    
    Item(id: UUID().uuidString, restaurant: "Olives", name: "Gyro in Pita", imageName: "gyroinpita", category: Category.food, description: "Our classic gyro in pita with tzatziki sauce on a grilled pita, with lettuce, tomato, and onions", price: 2.00, numberAvailable: 10),
    
    Item(id: UUID().uuidString, restaurant: "Olives", name: "BLT", imageName: "blt", category: Category.food, description: "The classic bacon, lettuce, and tomato on white toast with mayo.", price: 1.00, numberAvailable: 10),
    
    
    Item(id: UUID().uuidString, restaurant: "Olives", name: "Latte", imageName: "latte", category: Category.food, description: "A typical latte is made with six to eight ounces of steamed milk and one shot of espresso. Larger lattes are often made with a double shot of espresso.", price: 2.50, numberAvailable: 10),
        
                    
    // DRINK
    Item(id: UUID().uuidString, restaurant: "Hoagie Haven", name: "Filter Classic", imageName: "filter coffee", category: Category.drink, description: "Filter coffee brewing involves pouring hot water over coffee grounds. Gravity then pulls the water through the grounds, facilitating extraction, and dispenses it into a mug or carafe placed below.", price: 2.00, numberAvailable: 10),
    
    Item(id: UUID().uuidString, restaurant: "Hoagie Haven", name: "Filter Decaf", imageName: "decaf", category: Category.drink, description: "Filter coffee brewing involves pouring hot water over coffee grounds. Gravity then pulls the water through the grounds, facilitating extraction, and dispenses it into a mug or carafe placed below.", price: 2.00, numberAvailable: 10),

    Item(id: UUID().uuidString, restaurant: "Hoagie Haven", name: "Cold Brew", imageName: "cold brew", category: Category.drink, description: "Cold brew is really as simple as mixing ground coffee with cool water and steeping the mixture in the fridge overnight.", price: 2.50, numberAvailable: 10),

    Item(id: UUID().uuidString, restaurant: "Hoagie Haven", name: "Cold Brew Latte", imageName: "brew latte", category: Category.drink, description: "To make a weaker brew, add 2 parts cold brew coffee to 1 part hot water. For a stronger brew, use a 4:1 ratio. Cold Brew Concentrate for Iced Lattes: use 3 ounces coffee beans per 2.5 cups of water.", price: 2.00, numberAvailable: 10),
    
]
