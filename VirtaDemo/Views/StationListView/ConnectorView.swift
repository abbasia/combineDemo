//
//  ConnectorView.swift
//  VirtaDemo
//
//  Created by abbasi on 8.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct ConnectorView: View {
    var connector:Connector
    let viewModel = ConnectorViewModel()
    var body: some View {
        HStack(){
            Image("icType2")
            VStack{
                Text(viewModel.maxKwString(maxKw: connector.maxKw)).fontWeight(.heavy).foregroundColor(Colors.StationRowTitleColor).font(.system(size: 24))
                Text("kW").fontWeight(.ultraLight).foregroundColor(.gray).font(.system(size: 14))
            }
            Spacer()
                .frame(width: 10)
            
        }.frame(height:50)
    }
}
