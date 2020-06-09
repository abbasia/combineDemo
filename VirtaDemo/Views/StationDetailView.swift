//
//  StationDetailView.swift
//  VirtaDemo
//
//  Created by abbasi on 9.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct StationDetailView: View {
    @Binding var showDetail:Bool
    let viewModel: StationDetailViewModel
    
    init(_ appModel:AppModel, _ station: Station, showDetail: Binding<Bool>){
        self.viewModel = StationDetailViewModel(appModel, station)
        self._showDetail = showDetail
    }
    
    var body: some View {
        VStack(alignment: .leading){
            header
            Spacer()
            ScrollView(){
                Text("")
            }
        }
        
    }
    
    var header: some View {
        VStack(alignment: .leading){
            nameAddressCloseButton
            distanceStack
            Divider()
        }
        .frame(height:100)
        .background(Color.white)
        
    }
    
    var distanceStack: some View {
        HStack(alignment: .bottom){
            Spacer()
            HStack(){
                Text(self.viewModel.distanceFromUserString).font(.system(size: 14))
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                Image("icNavigate")
            }
        }
    }
    var nameAddressCloseButton: some View {
        HStack(alignment: .top){
            nameAndAddress
            Spacer()
            closeButton
        }.padding(.horizontal, 20)
        
    }
    
    var closeButton: some View {
        Button(action: {
            self.showDetail = false
        }){
            Image("icX")
        }.padding(.top, 10)
    }
    
    
    var nameAndAddress: some View {
        VStack(alignment: .leading){
            Text(self.viewModel.stationName)
                .fontWeight(.heavy)
                .foregroundColor(Colors.StationRowTitleColor)
                .font(.system(size: 24))
                .padding(.top, 10)
            
            Text(self.viewModel.stationAddressString)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.top, 10)
        }
    }
}


