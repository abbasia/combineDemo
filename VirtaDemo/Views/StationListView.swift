//
//  StationListView.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct StationRow: View {
    var station: Station

    var body: some View {
        Text("\(station.name ?? "no name")")
    }
}
struct StationListView: View {
    @ObservedObject var  stationsViewModel: StationsViewModel
    var body: some View {
        /*
        List(stationsViewModel.stations) { station in
               StationRow(station: station)
           }
 */
        
        VStack{
            Text("Station List View")
            List(stationsViewModel.stations) { station in
                StationRow(station: station)
            }
            Button(action: { self.stationsViewModel.appModel.clearToken() }) {
               Text("clear token")
            }.padding(.vertical, 10)
        }
 
        
    }
    
    init(_ appModel:AppModel){
        stationsViewModel = StationsViewModel( appModel)
    }
}

