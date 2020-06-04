//
//  VirtaDemoModel.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
class User: ObservableObject {
    var username = ""
    var password = ""
    @Published private(set) var isLoggedIn = false
    
    @UserDefault("token", defaultValue: "")
    private var token: String {
        didSet {
            isLoggedIn = token == "" ? false:true
        }
    }
    func clearToken(){
        token = ""
    }
    
}
final class VirtaDemoModel: ObservableObject {

    @Published var user = User()

    var sub: Cancellable? = nil
    func logout()  {
        user.clearToken()
    }
    func login()  {
        //On launch show login screen if not logged in yet. Login endpoint: `POST https://apitest.virta.fi/v4/auth`
        //The user credentials are: `candidate1@virta.global` pw: `1Candidate!`
        print("login pressed")
        print(user.username)
        print(user.password)
 
        //LoginRequestWithCombine(email: "candidate1@virta.global", password: "1Candidate!")
        
        sub = Webservice.login(email: "candidate1@virta.global", password: "1Candidate!")
            .sink(receiveCompletion: { print ($0) },
                  receiveValue: { print ($0) })
 
        
        /*
        LoginRequest(email: "candidate1@virta.global", password: "1Candidate!"){(result,error) in
            if let result = result {
                   //print("success: \(result)")
               } else if let error = error {
                   print("error: \(error.localizedDescription)")
               }
            
        }
 */
        
        
    }
    
    func LoginRequestWithCombine(email:String, password:String){
        
        let url = URL(string: "https://apitest.virta.fi/v4/auth")!
        
        
        /*
         let encoder = JSONEncoder()
        let loginData = LoginData(email: email, code: password)
        guard let postData = try? encoder.encode(loginData) else {
            fatalError("encoding errro: \(loginData)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = postData as Data
        */
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        let parameters = ["email": email, "code": password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            
        }

        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        sub = URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completionError) in
                switch completionError {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished:
                    break
                }
            }) { (data) in
                print(data)
                guard let stringData = String(data: data, encoding: .utf8) else {return}
                print(stringData)
        }
        
        
    }
    func LoginRequest(email: String, password: String, completion: @escaping ([String: Any]?, Error?) -> Void) {

        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["email": email, "code": password]

        //create the url with NSURL
        let url = URL(string: "https://apitest.virta.fi/v4/auth")!

        //create the session object
        let session = URLSession.shared

        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }

        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            print(data)
            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                //print(json)
                print("json.keys: \(json.keys)")
                print(json["token"])
                completion(json, nil)
            } catch let error {
                //print(error.localizedDescription)
                completion(nil, error)
            }
        })

        task.resume()
    }
}
