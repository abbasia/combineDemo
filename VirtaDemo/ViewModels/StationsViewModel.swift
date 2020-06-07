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
    let locationProxy: LocationProxy = LocationProxy()
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var stations = [Station]()
    @Published var filteredStations = [Station]()
    @Published var userLocation: CLLocation?
    let geodecoder = GeoDecoder()
    
    var filteredStationsByDistancePublisher: AnyPublisher<([Station]),Never>{
        Publishers.CombineLatest($stations, $userLocation).map { (stations,userLocation) -> [Station]  in
            if userLocation != nil {
                let mapped = stations.map { (station) -> Station in
                    var s: Station = station
                    let stationLocation = CLLocation(latitude: station.latitude, longitude: station.longitude)
                    let distanceFromUser = stationLocation.distance(from: userLocation!)
                    s.distanceFromUser = distanceFromUser
                    return s
                }
                return mapped
            }
            return stations
        }.map({ (stations)  in
            let sorted = stations.sorted { (s1, s2) in
                (s1.distanceFromUser ?? 0) < (s2.distanceFromUser ?? 0)
            }
            let arraySlice = sorted.prefix(10)
            return Array(arraySlice)
        })
        .eraseToAnyPublisher()
    }
    
    func getUserLocation(){
        locationProxy.requestAuthorization()
        locationProxy.startUpdaingLocation()
    }
    
    func getStations(){
        Webservice.getStations()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in  },
                receiveValue: {
                    self.stations = $0
                    self.getUserLocation()
            })
            
            .store(in: &cancellableSet)
    }
    init(_ appModel: AppModel) {
        self.appModel = appModel
        self.subscribeToLocationProxy()
        self.subscribeToFilteredStationsByDistancePublisher()
        
        self.getStations()
    }
    
    func subscribeToLocationProxy() {
        locationProxy
        .$location
        .compactMap{$0}
        .assign(to: \.userLocation, on: self)
        .store(in: &cancellableSet)
    }
    
    func subscribeToFilteredStationsByDistancePublisher(){
        filteredStationsByDistancePublisher
            .assign(to: \.filteredStations, on: self)
            .store(in: &cancellableSet)
        
        $filteredStations.sink { (stations) in
            self.geodecoder.startDecoding(stations: stations)
        }.store(in: &cancellableSet)
    }
}
