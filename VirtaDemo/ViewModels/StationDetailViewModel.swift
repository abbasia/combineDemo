//
//  StationDetailViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 9.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation

final class StationDetailViewModel: ObservableObject{
    let appModel:AppModel
    let station: Station
    
    init(_ appModel: AppModel, _ station: Station) {
        self.appModel = appModel
        self.station = station
        self.getStationDetails()
        
    }
    
    func getStationDetails()  {
        Webservice.getStationDetails(id: station.id)
    }
    
    
    var stationName:String {
        return station.name ?? ""
    }
    
    var stationAddressString: String {
        return StationRowViewModel.getAddressString(station: self.station)
    }
    
    var distanceFromUserString: String {
        return StationRowViewModel.distanceFromUserString(distanceFromUser: station.distanceFromUser ?? 0)
    }
}
