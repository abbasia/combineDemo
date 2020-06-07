//
//  LocationProxy.swift
//  VirtaDemo
//
//  Created by abbasi on 6.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

final class LocationProxy: NSObject, CLLocationManagerDelegate{
    let manager: CLLocationManager = CLLocationManager()
    @Published var location:CLLocation? = nil
    
    override init() {
        super.init()
        manager.delegate = self
        manager.activityType = .automotiveNavigation
        manager.distanceFilter = 150
            
    }
    func requestAuthorization(){
        manager.requestWhenInUseAuthorization()
    }
    func startUpdaingLocation(){
        manager.startUpdatingLocation()
    }
    
    func stopUpdaingLocation(){
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
    }
    
    
    
    
    
}
