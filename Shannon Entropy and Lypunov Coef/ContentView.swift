import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var plotData: PlotClass
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
                        await calculateShannonEntropy()
                    }
                })
                .padding()

                Button("Plot Lyapunov Exponents", action: {
                    Task {
                        await calculateLyapunovExponents()
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
            // Ensuring all UI updates are handled in the main thread
            updatePlotDataWithShannonResults(results: results)
        }
    }

    /// Calculates Lyapunov exponents and updates the plot data model and text output
    func calculateLyapunovExponents() async {
        let results = LyapunovCalc.calculateLyapunov()  // Call the static method correctly
        await MainActor.run {
  
            updatePlotDataWithLyapunovResults(results: results)
        }
    }

    // Helper methods to update plot data
    @MainActor private func updatePlotDataWithShannonResults(results: [(mu: Double, entropy: Double)]) {
        plotData.plotArray[selector].plotData = results.map { PlotDataStruct(xVal: $0.mu, yVal: $0.entropy) }
        plotData.plotArray[selector].calculatedText = results.map { "mu: \($0.mu), entropy: \($0.entropy)" }.joined(separator: "\n")
    }

    @MainActor private func updatePlotDataWithLyapunovResults(results: [(Double, Double, Double)]) {
        plotData.plotArray[selector].plotData = results.map { PlotDataStruct(xVal: $0.0, yVal: $0.2) }
        plotData.plotArray[selector].calculatedText = results.map { "m: \($0.0), y: \($0.1), Lyapunov: \($0.2)" }.joined(separator: "\n")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PlotClass())
    }
}
