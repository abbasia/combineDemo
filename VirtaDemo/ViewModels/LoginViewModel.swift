//
//  LoginViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 5.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
enum NotificationType {
    case Failure
    case Success
}
struct Notification {
    let message:String
    let type: NotificationType
    
    var color: Color {
        return ((self.type == .Success) ? Color.green : Color.red)
    }
}
final class LoginViewModel: ObservableObject {
    let appModel:AppModel
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var notification: Notification = Notification(message: "", type: .Success)
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    func login()  {
        
        //Webservice.login(email: "candidate1@virta.global", password: "1Candidate!")
        Webservice.login(email: username, password: password)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (status) in
                switch status {
                case .failure(let error):
                    print(error.localizedDescription)
                    self.notification = Notification(message: error.localizedDescription, type: .Failure)
                case .finished:
                    self.notification = Notification(message:"operation completed successfully" , type: .Success)
                    break
                }  },
                  receiveValue: { self.appModel.saveToken(token: $0)})
            .store(in: &cancellableSet)
        
    }
    
    func populateCorrectCredentials(){
        username = "candidate1@virta.global"
        password = "1Candidate"
    }
    
    func populateWrongCredentials(){
        username = "candidate2@virta.global"
        password = "1Candidate"
    }
    
    init(_ appModel: AppModel) {
        self.appModel = appModel
    }
}
