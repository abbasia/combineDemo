//
//  StationRowHeader.swift
//  VirtaDemo
//
//  Created by abbasi on 8.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct StationRowHeader: View {
    @ObservedObject var station: Station
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text("\(station.name ?? "no name")").fontWeight(.bold).foregroundColor(Colors.StationRowTitleColor)
                Spacer()
                HStack(){
                    Text("\(StationRowViewModel.distanceFromUserString(distanceFromUser: station.distanceFromUser ?? 0)) ")
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Image("icNavigate")
                    
                }
            }
            Text("\(StationRowViewModel.getAddressString(station: station))").fontWeight(.light).foregroundColor(.gray)
            
        }.frame(height:60)
    }
}
