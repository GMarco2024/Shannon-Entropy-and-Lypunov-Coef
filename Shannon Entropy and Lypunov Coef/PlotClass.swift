//
//  PlotClass.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//  Modified by Marco Gonzalez 04/29/2024
//

import Foundation
import Observation

@Observable class PlotClass {
    
    var plotArray = [PlotDataClass.init(fromLine: true)]
    
    init() {
        self.plotArray = [PlotDataClass.init(fromLine: true)]
        self.plotArray.append(contentsOf: [PlotDataClass.init(fromLine: true)])
            
        }

    
}
