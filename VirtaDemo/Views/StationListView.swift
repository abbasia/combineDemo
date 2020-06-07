//
//  StationListView.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

let stationsBackgroundColor = Color(red: 237/255, green: 239/255, blue: 241/255)

struct StationRow: View {
    var station: Station

    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("\(station.name ?? "no name")").bold()
                    Text("\(station.city ?? "")")
                }
            }
        }
    }
}
struct StationListView: View {
    @ObservedObject var  stationsViewModel: StationsViewModel
    var body: some View {
        
        VStack{
            Text("Near by")
                .fontWeight(.medium)
                .padding(.top, 50)
                .foregroundColor(.gray)
            Divider()
            
            
            List(stationsViewModel.filteredStations) { station in
                StationRow(station: station).background(Color.clear)
            }
 
            Button(action: { self.stationsViewModel.appModel.clearToken() }) {
               Text("clear token")
            }.padding(.vertical, 10)
            }.background(stationsBackgroundColor).edgesIgnoringSafeArea(.top)
 
        
    }
    
    init(_ appModel:AppModel){
        stationsViewModel = StationsViewModel( appModel)
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor.clear
    }
}

