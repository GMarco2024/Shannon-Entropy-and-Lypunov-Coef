//
//  PlotDataStruct.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//  Modified by Marco Gonzalez 04/29/2024
//

import Foundation
import Charts

// This defines a structure for storing individual data points for plotting in which onforms to Identifiable to facilitate its use in lists and views that require elements that can be identified.
struct PlotDataStruct: Identifiable {
    // Provides a unique identifier for each data point, using the x-value as its unique ID.
    var id: Double { xVal }
    
    // The x-coordinate of the data point, representing a specific dimension or parameter.
    let xVal: Double
    
    // The y-coordinate of the data point, typically representing the value or outcome at the corresponding x-value.
    let yVal: Double
}
