//
//  StationsViewModel.swift
//  VirtaDemo
//
//  Created by abbasi on 5.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import Foundation
import Combine
final class StationsViewModel: ObservableObject
{
    let appModel:AppModel
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var stations = [Station]()
    
    func getStations(){
        Webservice.getStations()
            .receive(on: RunLoop.main)
            .map({ (stations)-> [Station] in
                let arraySlice = stations.prefix(5)
                return Array(arraySlice)
            })
            .sink(receiveCompletion: { print ($0) },
                receiveValue: {
                    let items: [Station] = $0
                    self.stations = $0
                    print($0.count)
                    print(self.stations.count)
                    print(self.stations)
            })
            .store(in: &cancellableSet)
    }
    init(_ appModel: AppModel) {
        self.appModel = appModel
        self.getStations()
        
    }
}
