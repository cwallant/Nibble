//
//  RestaurantRow.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/27/21.
//

import SwiftUI

struct RestaurantRow: View {
    @ObservedObject var basketListener = BasketListener()
    var categoryName: String
    var restaurants : [Restaurant]
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.restaurants) { restaurant in
                        
                        NavigationLink(destination: RestaurantDetail(restaurant: restaurant)) {
                            RestaurantItem(restaurant: restaurant)
                                .frame(width: 300)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
            
        }
    }
}

struct RestaurantRow_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantRow(categoryName: "TRENDING", restaurants: restaurantData)
    }
}
