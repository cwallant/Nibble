//
//  LoginView.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import SwiftUI

struct LoginView: View {
    
    @State var showingSignup = false
    @State var showingFinishReg = false

    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    var body: some View {
        
        VStack {
            
            Text(showingSignup ? "Sign Up" : "Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading) {
                    
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                        .padding([.leading, .trailing], 50)
                        
                    
                    TextField("Enter your email", text: $email)
                        .padding([.leading, .trailing], 50)
                    Divider()
                        .padding([.leading, .trailing], 50)
                    
                    
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                        .padding([.leading, .trailing], 50)
                    
                    SecureField("Enter your password", text: $password)
                        .padding([.leading, .trailing], 50)
                    Divider()
                        .padding([.leading, .trailing], 50)
                    
                    if showingSignup {
                        Text("Confirm Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                            .padding([.leading, .trailing], 50)
                        
                        SecureField("Confirm password", text: $repeatPassword)
                            .padding([.leading, .trailing], 50)
                        Divider()
                            .padding([.leading, .trailing], 50)
                    }
                    
                }
                .padding(.bottom, 15)
                .animation(.easeOut(duration: 0.1))
                //End of VStack
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.resetPassword()
                    }, label: {
                        Text(showingSignup ? "" : "Forgot Password?")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .padding([.leading, .trailing], 50)
                    })
                }//End of HStack
                
            } .padding(.horizontal, 6)
            //End of VStack
            
            Button(action: {

                self.showingSignup ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showingSignup ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }) //End of Button
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            SignUpView(showingSignup: $showingSignup)
            
            
        }//End of VStack
            .sheet(isPresented: $showingFinishReg) {
                FinishRegistrationView()
        }
        
    }//End of body
    
    
    private func loginUser() {
        
        if email != "" && password != "" {
            
            FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                
                if error != nil {
                    
                    print("error loging in: ", error!.localizedDescription)
                    return
                }
                
                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingFinishReg.toggle()
                }
                
            }
        }
        
    }
    
    private func signUpUser() {
        
        if email != "" && password != "" && repeatPassword != "" {
            if password == repeatPassword {
                
                FUser.registerUserWith(email: email, password: password) { (error) in
                    
                    if error != nil {
                        print("Error registering user: ", error!.localizedDescription)
                        return
                    }
                    print("user has been created")
                    //go back to the app
                    //check if user onboarding is done
                }

                
            } else {
                print("passwords dont match")
            }
            
            
        } else {
            print("Email and password must be set")
        }
        
    }
    
    private func resetPassword() {
        
        if email != "" {
            FUser.resetPassword(email: email) { (error) in
                if error != nil {
                    print("error sending reset password, ", error!.localizedDescription)
                    return
                }
                
                print("please check you email")
            }

        } else {
            //notify the suer
            
            print("email is empty")
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView : View {
    
    @Binding var showingSignup: Bool
    
    var body: some View {
        
        
        VStack {
            
            Spacer()
            
            HStack(spacing: 8) {
                
                Text(showingSignup ? "Already Have an Account?" : "Don't Have an Account?")
                    .foregroundColor(Color.gray.opacity(0.5))
                
                Button(action: {
                    
                    self.showingSignup.toggle()
                }, label: {
                    Text(showingSignup ? "Sign In" : "Sign Up")
                })
                    .foregroundColor(.blue)
                
            }//End of HStack
                .padding(.top, 25)
            
        } //End of VStack
    }
}
