//
//  LoginView.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI
import Combine
struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack{
            HeaderView
            HeaderImageView
            
            NotificationMessage
            
            UsernameField
            Divider()
            PasswordField
            Divider()
            
            LoginButton
            CorrectCredentialsButton
            WrongCredentialsButton
            
            
        }
    }
    
    var NotificationMessage: some View {
        Text(viewModel.notification.message)
        .font(.headline)
            .foregroundColor(viewModel.notification.color)
        .padding()
    }
    
    var LoginButton: some View {
        Button(action: self.viewModel.login) {
            Text("Log in")
            .font(.headline)
            .foregroundColor(Colors.StationRowTitleColor)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.yellow)
            .cornerRadius(5.0)
        }.padding(.vertical, 10)
    }
    
    var UsernameField:  some View {
        HStack(alignment: .center){
            Image("icPerson").padding(.leading, 10)
            TextField("username", text: $viewModel.username)
                .frame(height: 35)
                .autocapitalization(.none)
                .padding(.trailing,5)
        }.padding(.vertical, 5)
        
    }
    
    var PasswordField: some View {
        HStack(alignment: .center){
            Image("icLock").padding(.leading, 10)
            
            SecureField("password", text: $viewModel.password)
                .frame(height: 35)
                .autocapitalization(.none)
                .padding(.trailing,5)
        }.padding(.vertical, 5)
    }
    
    var HeaderView: some View {
        Text("Login and Charge!")
            .font(Font.headline)
            .fontWeight(.semibold)
            .foregroundColor(Colors.StationRowTitleColor)
            .padding(.top,20)
    }
    
    var HeaderImageView: some View {
        Image("login").padding(.vertical,20)
    }
    
    var CorrectCredentialsButton: some View {
        Button(action: self.viewModel.populateCorrectCredentials) {
            Text("Populate with correct credentials")
            .font(.headline)
            .foregroundColor(Colors.StationRowTitleColor)
            .padding()
            .frame( height: 60)
            .background(Color.yellow)
            .cornerRadius(5.0)
        }.padding(.vertical, 10)
    }
    
    var WrongCredentialsButton: some View {
        Button(action: self.viewModel.populateWrongCredentials) {
            Text("Populate with wrong credentials")
            .font(.headline)
            .foregroundColor(Colors.StationRowTitleColor)
            .padding()
            .frame( height: 60)
            .background(Color.yellow)
            .cornerRadius(5.0)
        }.padding(.vertical, 10)
    }
    
    init(_ appModel:AppModel){
        viewModel = LoginViewModel( appModel)
    }
}




