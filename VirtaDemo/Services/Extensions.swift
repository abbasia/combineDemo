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
import SwiftUI

extension CLGeocoder {
    func reverseGeocodeLocationPublisher(_ station: Station, preferredLocale locale: Locale? = nil) -> AnyPublisher<(Station,String), Error> {
        Future<(Station,String), Error> { promise in
            let location = CLLocation(latitude: station.latitude, longitude: station.longitude)
            return self.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
                guard let placemark = placemarks?.first else {
                    return promise(.failure(error ?? CLError(.geocodeFoundNoResult)))
                }
                let address = placemark.makeAddressString()
                return promise(.success((station,address)))
            }
        }.eraseToAnyPublisher()
    }
}

extension CLPlacemark {

    func makeAddressString() -> String {
        var combined = ""
        if let first = subThoroughfare, !first.isEmpty {
            combined += first
            combined = combined.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if let second = thoroughfare, !second.isEmpty {
            combined += " " + second
            combined = combined.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if let third = locality, !third.isEmpty {
            if combined.isEmpty {
                combined += "" + third
                combined = combined.trimmingCharacters(in: .whitespacesAndNewlines)
            }else{
                combined += ", " + third
                combined = combined.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        return combined
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct Colors {
    static let StationRowTitleColor = Color(red: 47/255, green: 70/255, blue: 90/255)
    static let StationViewBackgroundColor = Color(red: 237/255, green: 239/255, blue: 241/255)
}
