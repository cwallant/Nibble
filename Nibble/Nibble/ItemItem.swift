//
//  ItemItem.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 12/1/21.
//

import SwiftUI


struct ItemItem: View {
    var item:Item
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(item.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 5) {
                HStack() {
                    Text(item.name)
                        .foregroundColor(.primary)
                        .font(.headline)
                    Spacer()
                    Text("$\(item.price, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                Text(item.description)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(height: 40)
            }
        }
    }
}

struct ItemItem_Previews: PreviewProvider {
    static var previews: some View {
        ItemItem(item:itemData[0])
    }
}
