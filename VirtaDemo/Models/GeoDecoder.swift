//
//  GeoDecoder.swift
//  VirtaDemo
//
//  Created by abbasi on 7.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import  Combine
import CoreLocation
class GeoDecoder {
    @Published private var stations:[Station] = []
    private var decodedStations:[Station] = []
    let geocoder = CLGeocoder()
    private var cancellableSet: Set<AnyCancellable> = []
    init() {
        
        
    }
    func startDecoding(stations:[Station]) {
        self.stations = stations
        
        Publishers.Sequence(sequence: stations)
            .subscribe(on: DispatchQueue.global())
            .flatMap(maxPublishers: .max(1)) { (station)  in
            self.geocoder.reverseGeocodeLocationPublisher(station)
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            
        }) { (station,address) in
            station.address = address
            station.addressReady = true
        }.store(in: &cancellableSet)
        
        
         
    }
    
}

