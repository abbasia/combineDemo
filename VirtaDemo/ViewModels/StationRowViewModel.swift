//
//  StationRowViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 8.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
struct StationRowViewModel {
    let appModel: AppModel
    
    init(_ appModel: AppModel) {
        self.appModel = appModel
    }
    func connectorChunks(station: Station)->[[Connector]]{
        
        var allConnectors: [Connector] = []
        
        for evse in station.evses {
            if let connectors = evse?.connectors{
                    for connector in connectors{
                        allConnectors.append(connector)
                    }
            }
        }
        let chunked =  allConnectors.chunked(into: 3)
        //print(chunked)
        return chunked
        
    }
    
    static func distanceFromUserString(distanceFromUser:Double)->String {
        if ((distanceFromUser) < 1000){
            return String(format:"%.0f", distanceFromUser) + " m"
            
        }else{
            return String(format:"%.1f", (distanceFromUser)/1000) + " km"
        }
    }
    
    static func getAddressString(station:Station) -> String{
         return station.addressReady ? (station.address ?? ""): ""
    }
}
