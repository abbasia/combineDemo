//
//  LoginViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 5.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
final class LoginViewModel {
    let appModel:AppModel
    private var cancellableSet: Set<AnyCancellable> = []
    
    func login()  {
        
        Webservice.login(email: "candidate1@virta.global", password: "1Candidate!")
            .sink(receiveCompletion: { print ($0) },
                receiveValue: { self.appModel.saveToken(token: $0)})
            .store(in: &cancellableSet)
    
       }
    
    
    init(_ appModel: AppModel) {
        self.appModel = appModel
    }
}
