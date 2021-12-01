//
//  AccountView.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 12/1/21.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarTitle(Text("Account"))
            .navigationBarItems(trailing:
                Button(action: {
                    FUser.logOutCurrenUser { (error) in
                        print("error loging out user, ", error?.localizedDescription as Any)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Log Out")
                })
            )
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
