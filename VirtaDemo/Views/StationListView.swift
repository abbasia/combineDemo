//
//  StationListView.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct StationListView: View {
    let stationsViewModel: StationsViewModel
    var body: some View {
        VStack{
            Text("Station List View")
            Button(action: { self.stationsViewModel.appModel.clearToken() }) {
               Text("clear token")
            }.padding(.vertical, 10)
        }
        
    }
    
    init(_ appModel:AppModel){
        stationsViewModel = StationsViewModel( appModel)
    }
}

