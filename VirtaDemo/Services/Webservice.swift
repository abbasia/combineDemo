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
            .map({ $0.data })
            .decode(type: Token.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
         
        
        /*
        return session.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { try validate($0.data, $0.response)}
            .decode(type: Token.self, decoder: JSONDecoder())
            .map({ (token)  in
                print(token)
                return token
            })
            .eraseToAnyPublisher()
 */
        
    }
    
    internal static func validate(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        print(httpResponse.statusCode)
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
        print(data)
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

struct Station: Decodable, Identifiable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let name: String?
    let city: String
    let provider: String
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

