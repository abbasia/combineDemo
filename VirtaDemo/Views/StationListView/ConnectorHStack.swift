//
//  ConnectorHStack.swift
//  VirtaDemo
//
//  Created by abbasi on 8.6.2020.
//  Copyright © 2020 abbasi. All rights reserved.
//

import SwiftUI

struct ConnectorHStack: View {
    let connectors:[Connector]
    var body: some View {
        HStack(){
            ForEach(0..<self.connectors.count,id: \.self){ index in
                ConnectorView(connector: self.connectors[index])
            }
        }.frame(height:40)
    }
}
