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
        let locations = stations.map { (station) -> CLLocation in
            CLLocation(latitude: station.latitude, longitude: station.longitude)
        }
        
        Publishers.Sequence(sequence: locations).flatMap(maxPublishers: .max(1)) { (location)  in
            self.geocoder.reverseGeocodeLocationPublisher(location)
        }
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { completion in
            print("done")
        }) { (placemark) in
            print("placemark:", placemark.makeAddressString())
        }.store(in: &cancellableSet)
         
    }
    
}
