//
//  ConnectorViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 8.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation

struct ConnectorViewModel {
    
    func maxKwString(maxKw:Float?)->String{
        return String(format: "%.1f", maxKw ?? 0.0)
    }
}
