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
final class AppModel: ObservableObject {
    @Published var authToken:String? = nil
    @Published var isLoggedIn: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var checkTokenPublisher: ValidationPublisher {
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
        checkTokenPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoggedIn, on: self)
            .store(in: &cancellableSet)
        
        self.authToken =  StorageService.retrieveAuthToken()
    }
    
}
