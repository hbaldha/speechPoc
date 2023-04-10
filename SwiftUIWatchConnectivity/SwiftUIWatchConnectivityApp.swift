//
//  SwiftUIWatchConnectivityApp.swift
//  SwiftUIWatchConnectivity
//
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
