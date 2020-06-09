//
//  StationListView.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct StationListView: View {
    @ObservedObject var  stationsViewModel: StationsViewModel
    var body: some View {
        VStack(){
            Text("Near by")
                .fontWeight(.medium)
                .padding(.top, 50)
                .foregroundColor(.gray)
            Divider()
            Spacer().frame(height: 10)
            List(stationsViewModel.filteredStations) { station in
                StationRow(self.stationsViewModel.appModel, station)
            }
            
        }
        .background(Colors.StationViewBackgroundColor)
        .edgesIgnoringSafeArea(.top)
        
    }
    
    init(_ appModel:AppModel){
        stationsViewModel = StationsViewModel( appModel)
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor.clear
    }
}

