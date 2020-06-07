//
//  Extensions.swift
//  VirtaDemo
//
//  Created by abbasi on 6.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import CoreLocation
import Combine
import CoreLocation
extension CLGeocoder {
    func reverseGeocodeLocationPublisher(_ location: CLLocation, preferredLocale locale: Locale? = nil) -> AnyPublisher<CLPlacemark, Error> {
        Future<CLPlacemark, Error> { promise in
            self.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
                guard let placemark = placemarks?.first else {
                    return promise(.failure(error ?? CLError(.geocodeFoundNoResult)))
                }
                return promise(.success(placemark))
            }
        }.eraseToAnyPublisher()
    }
}

extension CLPlacemark {

    func makeAddressString() -> String {
        var combined = ""
        if let first = subThoroughfare, !first.isEmpty {
          combined += first
        }
        
        if let second = thoroughfare, !second.isEmpty {
          combined += " " + second
        }
        
        if let third = locality, !third.isEmpty {
          combined += ", " + third
        }
        return combined
    }
}

