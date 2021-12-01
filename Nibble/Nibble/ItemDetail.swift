//
//  ItemDetail.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 12/1/21.
//

import SwiftUI

struct ItemDetail: View {
    
    @State private var showingAlert = false
    @State private var showingLogin = false
    
    var item: Item
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .bottom) {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("$\(item.price, specifier: "%.2f")")
                            .foregroundColor(.white)
                            .font(.title)
                            .lineLimit(1)
                    }
                    .padding(.trailing)
                    .padding(.bottom)
                    
                } //End of HStack
            } // end of zstack
            .listRowInsets(EdgeInsets())
            
            Text(item.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
        
            HStack {
                Spacer()
                OrderButton(showAlert: $showingAlert, showLogin: $showingLogin, item: item)
                Spacer()
            }
            .padding(.top, 50)
        } // end of scroll view
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Added to Cart!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(item: itemData.first!)
    }
}


struct OrderButton : View {

    @ObservedObject var basketListener = BasketListener()

    @Binding var showAlert: Bool
    @Binding var showLogin: Bool

    var item: Item

    var body : some View {

        Button(action: {

            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {

                self.showAlert.toggle()
                self.addItemToBasket()

            } else  {
                self.showLogin.toggle()
            }


        }) {
            Text("Add to Cart")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
        .sheet(isPresented: self.$showLogin) {

            if FUser.currentUser() != nil {
                FinishRegistrationView()
            } else {
                LoginView()
            }
        }

    }

    private func addItemToBasket() {

        var orderBasket: OrderBasket!

        if self.basketListener.orderBasket != nil {

            orderBasket = self.basketListener.orderBasket
        } else {

            orderBasket = OrderBasket()
            orderBasket.ownerId = FUser.currentId()
            orderBasket.id = UUID().uuidString
        }

        orderBasket.add(self.item)
        orderBasket.saveBasketToFirestore()
    }

}

