//
//  TokenStore.swift
//  VirtaDemo
//
//  Created by abbasi on 3.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation


final class StorageService{
    private static let tokenKey = "Authtoken"
    static func saveAuthToken(token:String?) {
        if token != nil  {
        UserDefaults.standard.set(token, forKey: tokenKey)
        }else{
            UserDefaults.standard.set(nil, forKey: tokenKey)
        }
        
    }
    static func retrieveAuthToken() -> String? {
        return UserDefaults.standard.object(forKey: tokenKey) as? String ?? nil
    }
}



