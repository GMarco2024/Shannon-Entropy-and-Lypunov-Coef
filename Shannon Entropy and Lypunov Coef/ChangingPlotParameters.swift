//
//  ChangingPlotParameters.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//  Modified by Marco Gonzalez 04/29/2024
//

import SwiftUI
import Observation
@Observable class ChangingPlotParameters {
    
    //These plot parameters are adjustable
    
    var xLabel: String = "x"
    var yLabel: String = "y"
    var xMax : Double = 4.0
    var yMax : Double = 1.0
    var yMin : Double = -0.4
    var xMin : Double = 3.5
    var lineColor: Color = Color.blue
    var title: String = "Plot Title"
    
}
