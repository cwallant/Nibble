//
//  OrderBasketView.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import SwiftUI


struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    var body: some View {
        
        NavigationView {
            
            List {
                Section {
                    ForEach(self.basketListener.orderBasket?.items ?? []) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price, specifier: "%.2f")")
                        }//End of HStack
                    }//End of ForEach
                        .onDelete { (indexSet) in
                            self.deleteItems(at: indexSet)
                    }
                }
                
                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("Place Order")
                    }
                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
                
            } //End of List
            .navigationBarTitle("Current Order")
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing:
                Button(action: {
                    FUser.logOutCurrenUser { (error) in
                        print("error loging out user, ", error?.localizedDescription as Any)
                    }
                }, label: {
                    Text("Log Out")
                })
            )
            
            
        } //End of Navigation view
        
    }
    
    func deleteItems(at offsets: IndexSet) {
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
    
    
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}

