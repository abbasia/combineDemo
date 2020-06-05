//
//  ContentViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 5.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
final class ContentViewModel: ObservableObject {
    var appModel = AppModel()
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var isLoggedIn = false
    
    init() {
        appModel.isLoggedInPublisher.receive(on: RunLoop.main)
        .assign(to: \.isLoggedIn, on: self)
        .store(in: &cancellableSet)
        
        $isLoggedIn.sink { (loggedIn) in
            print("loggedIn value :\(loggedIn)")
            print("auth token: \(String(describing: self.appModel.authToken))")
        }.store(in: &cancellableSet)
    }
}

