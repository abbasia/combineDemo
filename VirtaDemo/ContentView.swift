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
    let contentViewModel = ContentViewModel()
    var body: some View {
        Group {
            LoginView()
            /*
            if demoModel.isLoggedIn {
                StationListView()
            } else {
                LoginView()
            }
 */
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
