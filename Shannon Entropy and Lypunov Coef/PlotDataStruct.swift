//
//  PlotDataStruct.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//  Modified by Marco Gonzalez 04/29/2024
//


import Foundation
import Charts

struct PlotDataStruct: Identifiable {
    var id: Double { xVal }
    let xVal: Double
    let yVal: Double
}

