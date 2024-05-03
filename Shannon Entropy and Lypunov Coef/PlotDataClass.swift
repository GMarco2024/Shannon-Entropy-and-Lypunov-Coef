//
//  PlotDataClass.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//  Modified by Marco Gonzalez 04/29/2024
//

import Foundation
import SwiftUI
import Observation

@Observable class PlotDataClass {
    
    // Holds the actual plot data points as an array of PlotDataStruct.
    @MainActor var plotData = [PlotDataStruct]()
    // Manages settings for plot appearance such as axis labels, limits, and colors.
    @MainActor var changingPlotParameters: ChangingPlotParameters = ChangingPlotParameters()
    // This holds text that used for calculation
    @MainActor var calculatedText = ""
    // This tracks the number of points plotted.
    @MainActor var pointNumber = 1.0
    
    init(fromLine line: Bool) {
        
        
     
        Task{
            //Intitialize the first plot
            await self.plotBlank()
            
        }
        
       }
    
    
    
    /// Displays a Blank Chart
    @MainActor func plotBlank()
    {
        zeroData()
        
        //set the Plot Parameters
        changingPlotParameters.yMax = 1.0
        changingPlotParameters.yMin = -0.4
        changingPlotParameters.xMax = 4.0
        changingPlotParameters.xMin = 3.5
        changingPlotParameters.xLabel = "x"
        changingPlotParameters.yLabel = "y"
        changingPlotParameters.lineColor = Color.red
        changingPlotParameters.title = "y = x"
        
        
        
    }
    
    /// Zeros Out The Data Being Plotted
    @MainActor func zeroData(){
            
            plotData = []
            pointNumber = 1.0
            
        }
    
    /// Append Data appends Data to the Plot. Increments the pointNumber for 1-D Data
    /// - Parameter dataPoint: Array of (x, y) data for plotting
    @MainActor func appendData(dataPoint: [(x: Double, y: Double)])
        {
          
            for item in dataPoint{
                
                let dataValue :[PlotDataStruct] =  [.init(xVal: item.x, yVal: item.y)]
                
                plotData.append(contentsOf: dataValue)
                pointNumber += 1.0
                
            }
            
        }
    
    

}
