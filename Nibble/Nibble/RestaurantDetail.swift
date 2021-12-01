//
//  RestaurantDetail.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import SwiftUI
import MapKit

struct RestaurantDetail: View {
    
    @State private var showingAlert = false
    @State private var showingLogin = false
    @ObservedObject var itemListener = ItemListener()
    @State private var showingBasket = false
    
    
    var restaurant: Restaurant
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .bottom) {
                Image(restaurant.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)

                    Spacer()
                } //End of HStack

                
            } // end of zstack
            .listRowInsets(EdgeInsets())
            VStack {
                Text(restaurant.description)
                    .foregroundColor(.primary)
                    .font(.body)
                    .lineLimit(5)
                    .padding()
            
                HStack {
                    Spacer()
                    ItemRow(items: itemListener.items.filter {item in
                        return item.restaurant == restaurant.name
                    })
                        .frame(height: 220)
                        .padding(.bottom)
                        //.padding(.top)
                    Spacer()
                }
                .padding(.top, 50)
            }
        } // end of scroll view
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Added to Cart!"), dismissButton: .default(Text("OK")))
        }
        .navigationBarItems(trailing: Button(action: {
                self.showingBasket.toggle()
            }, label: {
                Image("basket")
            })
                .sheet(isPresented: $showingBasket) {

                    if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                        OrderBasketView()
                    } else if FUser.currentUser() != nil {
                        FinishRegistrationView()
                    } else {
                        LoginView()
                    }
            }
        )
    }
}

struct RestaurantDetail_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetail(restaurant: restaurantData.first!)
    }
}
