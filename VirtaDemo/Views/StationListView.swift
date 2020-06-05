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
        Text("Station List View")
    }
    
    init(_ appModel:AppModel){
        stationsViewModel = StationsViewModel( appModel)
    }
}

