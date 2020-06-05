//
//  VirtaDemoModel.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
final class VirtaDemoModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var token:String?

    var sub: Cancellable? = nil
    func logout()  {
        token = nil
    }
    func login()  {
        sub = Webservice.login(email: "candidate1@virta.global", password: "1Candidate!")
            .sink(receiveCompletion: { print ($0) },
                  receiveValue: { token in
                    if let t = token.token {
                        self.token = t
                        self.isLoggedIn = true
                    }
            })
 
    }
}
