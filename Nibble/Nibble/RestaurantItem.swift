//
//  RestaurantItem.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/27/21.
//

import SwiftUI

struct RestaurantItem: View {
    var restaurant:Restaurant
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(restaurant.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 5) {
                Text(restaurant.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(restaurant.description)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(height: 40)
            }
        }
    }
}

struct RestaurantItem_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantItem(restaurant:restaurantData[0])
    }
}
