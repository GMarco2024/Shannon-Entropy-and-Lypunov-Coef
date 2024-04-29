//
//  CalculatePlotData.swift
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 04/29/2024
//
//

import Foundation
import SwiftUI
import Observation

@Observable class CalculatePlotData {
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    let shannonCalc = ShannonCalc()
    
    /// Set the Plot Parameters
    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String, xMin: Double, xMax: Double, yMin: Double, yMax: Double) {
        plotDataModel!.changingPlotParameters.yMax = yMax
        plotDataModel!.changingPlotParameters.yMin = yMin
        plotDataModel!.changingPlotParameters.xMax = xMax
        plotDataModel!.changingPlotParameters.xMin = xMin
        plotDataModel!.changingPlotParameters.xLabel = xLabel
        plotDataModel!.changingPlotParameters.yLabel = yLabel
        
        if color == "Red" {
            plotDataModel!.changingPlotParameters.lineColor = Color.red
        } else {
            plotDataModel!.changingPlotParameters.lineColor = Color.blue
        }
        plotDataModel!.changingPlotParameters.title = title
        
        plotDataModel!.zeroData()
    }
    
    /// Shannon entropy calculation function
    func calculateShannonEntropy() async {
        let results = shannonCalc.calculateShannon()
        
        await resetCalculatedTextOnMainThread()
        
        var plotData : [(x: Double, y: Double)] = []
        
        for result in results {
            plotData.append((x: result.mu, y: result.entropy))
            theText += "mu = \(result.mu), entropy = \(result.entropy)\n"
        }
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
    }
    
    /// Append data to plot
    @MainActor func appendDataToPlot(plotData: [(x: Double, y: Double)]) {
        plotDataModel!.appendData(dataPoint: plotData)
    }
    
    /// Reset the Calculated Text to ""
    @MainActor func resetCalculatedTextOnMainThread() {
        plotDataModel!.calculatedText = ""
    }
    
    /// Adds the passed text to the display in the main window
    @MainActor func updateCalculatedTextOnMainThread(theText: String) {
        plotDataModel!.calculatedText += theText
    }

    // New Lyapunov calculation function
    func calculateLyapunovExponents() async {
        let lyapunovResults = LyapunovCalc.calculateLyapunov()
        var plotData: [(x: Double, y: Double)] = []

        for (m, y, lyapunov) in lyapunovResults {
            plotData.append((x: m, y: lyapunov))
            theText += "m = \(m), y = \(y), Lyapunov = \(lyapunov)\n"
        }

        await setThePlotParameters(color: "Green", xLabel: "m", yLabel: "Lyapunov Exponent", title: "Lyapunov Exponents", xMin: LyapunovCalc.mMin, xMax: LyapunovCalc.mMax, yMin: plotData.map { $0.y }.min() ?? 0, yMax: plotData.map { $0.y }.max() ?? 1)

        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
    }
}

class ShannonCalc {
    var prob = [Double](repeating: 0.0, count: 1001)
    let nbin = 1000
    let nMax = 100000
    let semaphore = DispatchSemaphore(value: 1)

    func calculateShannon() -> [(mu: Double, entropy: Double)] {
        var results = [(mu: Double, entropy: Double)]()

        for mu in stride(from: 3.5, through: 4.0, by: 0.001) {
            prob = [Double](repeating: 0.0, count: nbin + 1)

            var x = 0.5
            for n in 1...nMax {
                x = mu * x * (1 - x)
                if n > 30000 {
                    let ibin = Int(x * Double(nbin))
                    if ibin > 0 && ibin <= nbin {
                        semaphore.wait()
                        prob[ibin] += 1
                        semaphore.signal()
                    }
                }
            }

            var entropy = 0.0
            for ibin in 1...nbin where prob[ibin] > 0 {
                let p = prob[ibin] / Double(nMax - 30000)
                if p > 0 {
                    entropy -= p * log(p)
                }
            }
            
           //The chapter asked to um, reduce the funciton by a factor of 5, which I did.
            entropy /= 5
            results.append((mu: mu, entropy: entropy))
        }
        return results
    }
}

// LyapunovCalc class to perform the Lyapunov exponent calculations
class LyapunovCalc {
    static let mMin = 2.8
    static let mMax = 4.0
    static let step = 0.002

    static func calculateLyapunov() -> [(Double, Double, Double)] {
        var results: [(Double, Double, Double)] = []

        var m = mMin
        while m <= mMax {
            var y = 0.5
            for _ in 1...20 {
                y = m * y * (1 - y)
            }

            var suma = 0.0
            for _ in 21...25 {
                y = m * y * (1 - y)
                suma += log(abs(m * (1 - 2 * y)))
                results.append((m, y, suma / 200))
            }
            m += step
        }
        return results
    }
}
