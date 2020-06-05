//
//  AppModel.swift
//  VirtaDemo
//
//  Created by abbasi on 5.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine

typealias ValidationPublisher = AnyPublisher<Bool,Never>

final class AppModel {
    @Published var authToken:String? = nil
    @Published var isLoggedIn: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
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
    
    init() {
        self.authToken =  StorageService.retrieveAuthToken()
    }
    
}
