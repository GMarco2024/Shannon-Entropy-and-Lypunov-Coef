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
    
    // Array of PlotDataClass instances. This changes to this array will update any SwiftUI views observing this object.
    @Published var plotArray = [PlotDataClass(fromLine: true)]
    
    // Creates an initial PlotDataClass instance configured to start with a blank plot. Initializes the plotArray with two instances of the same initial plot. This could be for showing multiple views or states of the same data set in some form.
    
    init() {
        self.plotArray = [PlotDataClass(fromLine: true)]
        self.plotArray.append(contentsOf: [PlotDataClass(fromLine: true)])
    }
}

