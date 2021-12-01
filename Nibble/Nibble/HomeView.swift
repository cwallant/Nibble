//
//  HomeView.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/24/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var restaurantListener = RestaurantListener()
    @State private var showingLogIn = false
    @ObservedObject var basketListener = BasketListener()
    
    var categories: [String : [Restaurant]] {
        .init(grouping: restaurantListener.restaurants, by: {$0.category})
    }
    var body: some View {
        NavigationView {
            
            List(categories.keys.sorted().reversed(), id: \String.self) { key in
                RestaurantRow(categoryName: "\(key)", restaurants: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.bottom)
                    .padding(.top)
            }
            
            .navigationBarTitle(Text("Princeton, NJ"))
            .navigationBarItems(trailing: Button(action: {
                    self.showingLogIn.toggle()
                }, label: {
                    Image(systemName: "person")
                })
                    .sheet(isPresented: $showingLogIn) {

                        if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                            AccountView()
                        } else if FUser.currentUser() != nil {
                            FinishRegistrationView()
                        } else {
                            LoginView()
                        }
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
