//
//  SwiftUIWatchConnectivityApp.swift
//  SwiftUIWatchConnectivity
//
//  Created by Chris Gaafary on 4/19/21.
//

import SwiftUI
import Speech

@main
struct SwiftUIWatchConnectivityApp: App {
	var swiftUISpeech = SwiftUISpeech()
    var body: some Scene {
        WindowGroup {
			ContentView().environmentObject(swiftUISpeech)
        }
    }
}
