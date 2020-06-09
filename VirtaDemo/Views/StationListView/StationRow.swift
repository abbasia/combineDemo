//
//  StationRow.swift
//  VirtaDemo
//
//  Created by abbasi on 8.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct StationRow: View {
    @ObservedObject var station: Station
    @State var showDetail = false
    
    let viewModel:StationRowViewModel
    let connectorChunks: [[Connector]]
    
    init(_ appModel: AppModel, _ station: Station) {
        self.station = station
        self.viewModel = StationRowViewModel(appModel)
        self.connectorChunks = viewModel.connectorChunks(station: station)
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer().frame(height: 5)
            Button(action: {
                self.showDetail.toggle()
            }){
                StationRowHeader(station: station)
                Spacer().frame(height: 10)
            }.sheet(isPresented: $showDetail) {
                StationDetailView(self.viewModel.appModel, self.station, showDetail: self.$showDetail)
            }
            
            ForEach(0..<self.connectorChunks.count,id: \.self){ index in
                ConnectorHStack(connectors: self.connectorChunks[index])
            }
            
            
            Colors.StationViewBackgroundColor.frame(height: 5)
        }
        .background(Color.clear)
    }
}
