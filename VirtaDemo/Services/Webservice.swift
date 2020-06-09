//
//  Webservice.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine

struct Webservice {
    
    static let session:URLSession = URLSession.shared
    static let baseUrl = "https://apitest.virta.fi/v4/"
    static let authUrl = "auth"
    static let stationsUrl = "stations"
    static  var cancellableSet: Set<AnyCancellable> = [] //remove later added for testing
    
    static func getStationDetails(id: Int){
        print("could not retrieve station detail because server was returning error 500")
        /*
        let url = URL(string: "\(baseUrl)\(stationsUrl)/\(id)")!
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTaskPublisher(for: request)
            .map({ $0.data })
            
            .map({
                do {
                    let json = try JSONSerialization.jsonObject(with: $0, options: .mutableContainers)
                    print(json)
                    
                } catch let error as NSError {
                    print(error)
                }
                return $0
            }).eraseToAnyPublisher()
            .sink(receiveCompletion: { _ in
                
            }) { (details) in
                print(details)
        }.store(in: &cancellableSet) //added for testing remove later
 */
        
    }
    
    static func getStations()-> AnyPublisher<[Station], Error>{
        //Stations endpoint: `GET https://apitest.virta.fi/v4/stations`
        let url = URL(string: "\(baseUrl)\(stationsUrl)")!
        let request = URLRequest(url: url)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map({ $0.data })
            .decode(type: [Station].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func login(email: String, password: String)-> AnyPublisher<Token, Error>{
        let url = URL(string: "\(baseUrl)\(authUrl)")!
        
        let encoder = JSONEncoder()
        
        let loginData = LoginData(email: email, code: password)
        guard let postData = try? encoder.encode(loginData) else {
            fatalError("encoding error: \(loginData)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData as Data
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { try validate($0.data, $0.response)}
            .map({ $0 })
            .decode(type: Token.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    internal static func validate(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        print(httpResponse.statusCode)
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
        return data
    }
    
}


struct LoginData: Codable {
    let email:String
    let code: String
}
struct Token: Decodable {
    let token:String?
    let token_type:String?
}


enum APIError: Error {
    case invalidBody
    case invalidEndpoint
    case invalidURL
    case emptyData
    case invalidJSON
    case invalidResponse
    case statusCode(Int)
}

