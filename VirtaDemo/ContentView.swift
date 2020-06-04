//
//  ContentView.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var demoModel: VirtaDemoModel
    
    var body: some View {
        //this works
        //demoModel.isLoggedIn ? Text("logged in"):Text("logged out")
        Group {
            if demoModel.user.isLoggedIn {
                StationListView()
            } else {
                LoginView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
