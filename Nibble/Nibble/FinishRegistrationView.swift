//
//  FinishRegistrationView.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import SwiftUI

struct FinishRegistrationView: View {
    
    @State var name = ""
    @State var lastname = ""
    @State var phonenumber = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

        Form {
            
            Section() {
                
                Text("Complete Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 20)
                
                TextField("First Name", text: $name)
                TextField("Last Name", text: $lastname)
                TextField("Phone Number", text: $phonenumber)
                
            } //End of Section
            
            
            Section() {
                
                Button(action: {
                    self.finishRegistration()
                }, label: {
                    Text("Finish Registration")
                })
            }.disabled(!self.fieldsCompleted())
            //End of Section
            
            
        } //End of Form

    }//End of Body
    
    private func fieldsCompleted() -> Bool {
        
        return self.name != "" && self.lastname != "" && self.phonenumber != ""
    }
    
    private func finishRegistration() {
        
        let fullName = name + " " + lastname
        
        updateCurrentUser(withValues: [kFIRSTNAME : name, kLASTNAME : lastname, kFULLNAME : fullName, kPHONENUMBER : phonenumber, kONBOARD : true]) { (error) in
            
            if error != nil {
                
                print("error updating user: ", error!.localizedDescription)
                return
            }
    
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}

