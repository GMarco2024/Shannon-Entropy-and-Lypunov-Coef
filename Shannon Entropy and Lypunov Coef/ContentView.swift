//
//  ContentView.swift
// 
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 04/29/24
//
//
//

import SwiftUI
import Charts

struct ContentView: View {
    @Environment(PlotClass.self) var plotData
    
    @State private var shannonCalculator = ShannonCalc()
    @State private var selector = 0
    
    var body: some View {
        VStack {
            Group {
                HStack(alignment: .center, spacing: 0) {
                    Text(plotData.plotArray[selector].changingPlotParameters.yLabel)
                        .rotationEffect(Angle(degrees: -90))
                        .foregroundColor(.red)
                        .padding()
                    
                    VStack {
                        Chart(plotData.plotArray[selector].plotData) {
                            LineMark(
                                x: .value("Position", $0.xVal),
                                y: .value("Height", $0.yVal)
                            )
                            .foregroundStyle(plotData.plotArray[selector].changingPlotParameters.lineColor)
                            PointMark(x: .value("Position", $0.xVal), y: .value("Height", $0.yVal))
                                .foregroundStyle(plotData.plotArray[selector].changingPlotParameters.lineColor)
                        }
                        .chartYScale(domain: [
                            plotData.plotArray[selector].changingPlotParameters.yMin,
                            plotData.plotArray[selector].changingPlotParameters.yMax
                        ])
                        .chartXScale(domain: [
                            plotData.plotArray[selector].changingPlotParameters.xMin,
                            plotData.plotArray[selector].changingPlotParameters.xMax
                        ])
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .padding()
                        Text(plotData.plotArray[selector].changingPlotParameters.xLabel)
                            .foregroundColor(.red)
                    }
                }
                .frame(alignment: .center)
                .padding()
            }
            
            Divider()

            HStack {
                Button("Plot Shannon Entropy", action: {
                    Task {
                        self.selector = 0
                        await self.calculateShannonEntropy()
                    }
                })
                .padding()
            }
        }
    }
    
    /// Calculates Shannon entropy and updates the plot data model
    func calculateShannonEntropy() async {
        let results = shannonCalculator.calculateShannon()
        await MainActor.run {
            // Assuming the format of results is appropriate, adjust if necessary
            plotData.plotArray[selector].plotData = results.map { PlotDataStruct(xVal: $0.mu, yVal: $0.entropy) }
            plotData.plotArray[selector].calculatedText = results.map { "mu: \($0.mu), entropy: \($0.entropy)" }.joined(separator: "\n")
        }
    }
}

#Preview {
    ContentView()
}
