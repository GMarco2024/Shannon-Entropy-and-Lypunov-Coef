//
//  PlotClass.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//  Modified by Marco Gonzalez 04/29/2024
//

import Foundation
import SwiftUI

class PlotClass: ObservableObject {
    
    @Published var plotArray = [PlotDataClass(fromLine: true)]
    
    init() {
        self.plotArray = [PlotDataClass(fromLine: true)]
        self.plotArray.append(contentsOf: [PlotDataClass(fromLine: true)])
    }
}

