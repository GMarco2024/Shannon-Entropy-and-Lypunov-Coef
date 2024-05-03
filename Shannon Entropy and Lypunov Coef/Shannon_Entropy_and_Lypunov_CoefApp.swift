//
//  Shannon_Entropy_and_Lypunov_CoefApp.swift
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez

import SwiftUI

@main
struct Shannon_Entropy_and_Lypunov_CoefApp: App {
    
    // Declare an instance of PlotClass to manage and pass data throughout the views as an environment object.
    @StateObject var plotData = PlotClass()

    // Defines the body of the app which provides the content view.
    var body: some Scene {
        WindowGroup {
            TabView {
                
            //First tab properties.
            //Here we have the labeling for the tabs created in the GUI.
                ContentView()
                    .environmentObject(plotData)
                    .tabItem {
                        Label("Plot", systemImage: "chart.xyaxis.line")
                    }
                
            //Here we have the labeling for the tabs created in the GUI.
                TextView()
                    .environmentObject(plotData)
                    .tabItem {
                        Label("Text", systemImage: "text.alignleft")
                    }
            }
        }
    }
}

