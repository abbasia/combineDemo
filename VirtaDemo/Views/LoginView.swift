//
//  LoginView.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

let titleColor = Color(red: 47/255, green: 70/255, blue: 90/255)

struct LoginView: View {
    @EnvironmentObject var demoModel: VirtaDemoModel
    var body: some View {
        VStack{
            TitleView()
            
            HeaderImageView()
            
            UsernameField(username: $demoModel.user.username)
            Divider()
            PasswordField(password: $demoModel.user.password)
            Divider()
            
            Button(action: {
                self.demoModel.login()
                
            }) {
               ButtonContent()
            }.padding(.vertical, 10)
            Spacer()
        }
        
    }
}


struct TitleView: View {
    var body: some View {
        Text("Login and Charge!")
            .font(Font.headline)
            .fontWeight(.semibold)
            .foregroundColor(titleColor)
            .padding(.top,20)
    }
}


struct HeaderImageView: View {
    var body: some View {
        Image("login").padding(.vertical,20)
    }
}

struct UsernameField: View {
    @Binding var username:String
    var body: some View {
        HStack(alignment: .center){
            Image("icPerson").padding(.leading, 10)
            TextField("", text: $username)
                  .frame(height: 35)
                  .autocapitalization(.none)
            //      .background(Color.red)
                  .padding(.trailing,5)
        }.padding(.vertical, 5)
    }
}


struct PasswordField: View {
    @Binding var password:String
    var body: some View {
        HStack(alignment: .center){
            Image("icLock").padding(.leading, 10)
                
            SecureField("", text: $password)
                  .frame(height: 35)
                  .autocapitalization(.none)
            //      .background(Color.red)
                  .padding(.trailing,5)
        }.padding(.vertical, 5)
    }
}



struct PlaceholderTextField: View {
    let isPassword:Bool
    var placeholder: Text
    @Binding var text: String
    
    var body: some View {
            TextField("", text: $text)
                .frame(height: 35)
                .autocapitalization(.none)
          //      .background(Color.red)
                .padding(.trailing,5)
    }
}

struct ButtonContent: View {
    var body: some View {
        Text("Log in")
        .font(.headline)
        .foregroundColor(titleColor)
        .padding()
        .frame(width: 220, height: 60)
        .background(Color.yellow)
        .cornerRadius(5.0)
    }
}



