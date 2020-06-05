//
//  StationsViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 5.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
import  CoreLocation
final class StationsViewModel: ObservableObject
{
    let appModel:AppModel
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var stations = [Station]()
    
    func getStations(){
        Webservice.getStations()
            .receive(on: RunLoop.main)
            .map({ stations-> [Station] in
                for station in stations {
                    let location = CLLocation(latitude: station.latitude, longitude: station.longitude)
                    let geocoder = CLGeocoder()

                    var placemark: CLPlacemark?

                    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                      if error != nil {
                        print("something went horribly wrong")
                        print(error)
                      }

                      if let placemarks = placemarks {
                        placemark = placemarks.first
                      }
                        print("computed address: \(String(describing: placemark))")
                    }
                }
                return stations
            })
            .map({ (stations)-> [Station] in
                let arraySlice = stations.prefix(5)
                return Array(arraySlice)
            })
            .sink(receiveCompletion: { print ($0) },
                receiveValue: {
                    //let items: [Station] = $0
                    self.stations = $0
                    //print($0.count)
                    //print(self.stations.count)
                    //print(self.stations)
            })
            
            .store(in: &cancellableSet)
    }
    init(_ appModel: AppModel) {
        self.appModel = appModel
        self.getStations()
        
    }
}
