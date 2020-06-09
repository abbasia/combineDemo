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
    @ObservedObject var contentViewModel = ContentViewModel()
    var body: some View {
        Group {
            if contentViewModel.isLoggedIn {
                StationListView(contentViewModel.appModel)
            } else {
                LoginView(contentViewModel.appModel)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
