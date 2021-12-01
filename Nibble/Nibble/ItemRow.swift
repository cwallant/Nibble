//
//  ItemRow.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 12/1/21.
//

import SwiftUI

struct ItemRow: View {
    var items : [Item]
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.items) { item in
                        NavigationLink(destination: ItemDetail(item: item)) {
                            ItemItem(item: item)
                                .frame(width: 300)
                                .padding(.trailing, 30)
                        }
                    }
                }
            }
            
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(items: itemData)
    }
}
