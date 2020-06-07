//
//  AppModel.swift
//  VirtaDemo
//
//  Created by abbasi on 5.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

typealias ValidationPublisher = AnyPublisher<Bool,Never>

struct Station: Decodable, Identifiable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let name: String?
    let city: String
    let provider: String
    var distanceFromUser:Double? = 0
}




final class AppModel {
    @Published var authToken:String? = nil
    @Published var isLoggedIn: Bool = false
    
    
    
    var isLoggedInPublisher: ValidationPublisher {
        $authToken.map { (token) -> Bool in
            if token != nil  {
                return true
            }
            return false
        }.eraseToAnyPublisher()
    }
    
    func clearToken(){
        self.authToken = nil
        StorageService.saveAuthToken(token: nil)
    }
    
    func  saveToken(token:Token) {
        self.authToken = token.token
        StorageService.saveAuthToken(token: self.authToken)
    }
    
    init() {
        self.authToken =  StorageService.retrieveAuthToken()
    }
    
}
