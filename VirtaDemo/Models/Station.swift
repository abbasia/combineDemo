//
//  Station.swift
//  VirtaDemo
//
//  Created by abbasi on 7.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
struct Connector: Decodable,Identifiable {
    var id = Int.random(in: 1..<100000)
    var maxKw: Float?
    var type: String?
    private enum CodingKeys: String, CodingKey {
        case maxKw,type
        
    }
}
struct Evse: Decodable,Identifiable {
    var id: Int?
    var groupName: String?
    var connectors: [Connector]?
}
class Station: Decodable, Identifiable, ObservableObject{
    var id: Int
    var latitude: Double
    var longitude: Double
    var name: String?
    var city: String
    var provider: String
    var distanceFromUser:Double? = 0
    var evses: [Evse?]
    @Published var address:String? = ""
    @Published var addressReady: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id,latitude,longitude,name,city,provider,evses
        
    }
    
}
