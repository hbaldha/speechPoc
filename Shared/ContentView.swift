//
//  ContentView.swift
//  WatchConnectivityPrototype

import SwiftUI
import WatchConnectivity
import Speech

struct ContentView: View {
    @StateObject var counter = Counter()
	@EnvironmentObject var swiftUISpeech:SwiftUISpeech
	
    var labelStyle: some LabelStyle {
        #if os(watchOS)
        return IconOnlyLabelStyle()
        #else
        return DefaultLabelStyle()
        #endif
    }
	
	var body: some View {
		ZStack {
			VStack {
				let screenSize: CGRect = UIScreen.main.bounds
				Spacer(minLength: (screenSize.height / 3))
				VStack {
					Text("Welcome!!")
					Text("Click wave icon to start and click again to stop").multilineTextAlignment(.center)
				}
				Spacer(minLength: 50)
				VStack {
					swiftUISpeech.getButton()
					Spacer()
				}
				VStack {
					Text("\(swiftUISpeech.outputText)").onChange(of: swiftUISpeech.outputText) { newValue in
						sendMessage()
					}
				}.frame(width: 300,height: 100)
			}
		}
	}
	
	func sendMessage() {
		if swiftUISpeech.outputText.lowercased().contains("qr") {
			counter.increment(counts: 1)
		}
		else if swiftUISpeech.outputText.lowercased().contains("transaction") {
			counter.increment(counts: 2)
		}
	}
}
