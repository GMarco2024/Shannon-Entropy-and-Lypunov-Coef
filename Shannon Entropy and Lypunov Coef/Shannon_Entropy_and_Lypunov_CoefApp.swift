//
//  Shannon_Entropy_and_Lypunov_CoefApp.swift
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez

import SwiftUI

@main
struct Shannon_Entropy_and_Lypunov_CoefApp: App {
    @StateObject var plotData = PlotClass()

    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotData)
                    .tabItem {
                        Label("Plot", systemImage: "chart.xyaxis.line")
                    }
                TextView()
                    .environmentObject(plotData)
                    .tabItem {
                        Label("Text", systemImage: "text.alignleft")
                    }
            }
        }
    }
}

