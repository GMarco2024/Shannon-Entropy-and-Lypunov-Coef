//
//  Shannon_Entropy_and_Lypunov_CoefApp.swift
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez

import SwiftUI
import Observation

@main
struct Shannon_Entropy_and_Lypunov_CoefApp: App {
    
    @State var plotData = PlotClass()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environment(plotData)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environment(plotData)
                    .tabItem {
                        Text("Text")
                        
                }
            }
        }
    }
}
