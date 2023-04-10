//
//  SwiftUIWatchConnectivityApp.swift
//  SwiftUIWatchConnectivity WatchKit Extension
//
import SwiftUI

@main
struct SwiftUIWatchConnectivityApp: App {
    var body: some Scene {
        WindowGroup {
			if #available(watchOSApplicationExtension 9.0, *) {
				NavigationStack {
					ContentView1()
				}
			} else {
				// Fallback on earlier versions
			}
        }
    }
}


struct ContentView1: View {
	@State private var ispassrequier = false
	var labelStyle: some LabelStyle {
		#if os(watchOS)
		return IconOnlyLabelStyle()
		#else
		return DefaultLabelStyle()
		#endif
	}
	
	var body: some View {
		VStack {
			ContentViewPin()
		}
	}
}

struct Superhero: Identifiable {
	var id = UUID()
	var name: String
	var amount: String
	var type: String
}

var superheroes = [
	Superhero(name: "John", amount: "20 QAR", type: "credit"),
	Superhero(name: "Mike", amount: "200 QAR", type: "credit"),
	Superhero(name: "John", amount: "230 QAR", type: "credit"),
	Superhero(name: "test", amount: "210 QAR", type: "debit"),
	Superhero(name: "Sia", amount: "2110 QAR", type: "debit"),
	Superhero(name: "John", amount: "210 QAR", type: "credit"),
]

struct TransactionView: View{
	var body: some View {
		VStack {
			List {
				ForEach(superheroes) { item in
					VStack(alignment: .leading, content: {
						Text(item.name)
						if item.type == "credit" {
							Text(item.amount).foregroundColor(.green)
						} else {
							Text(item.amount).foregroundColor(.red)
						}
					})
			   }
		   }
		}
	}
}

struct FullscreenImageView: View {
	var body: some View {
		Image("qrcode")
			.resizable()
			.scaledToFit()
	}
}



struct ContentViewPin: View {
	@State private var ispassrequier = false
	var textField: WKInterfaceTextField!
	@State private var text: String = ""
	@StateObject var counter = Counter()
	
	var body: some View {
		if #available(watchOSApplicationExtension 9.0, *) {
			NavigationStack {
				Text("Welcome!!")
				VStack {
					SecureField("Pin", text: $text)
						.padding(.horizontal)
						.disableAutocorrection(true)
					
					Button(action: {
						ispassrequier = true
					}) {
						Text("Confirm")
					}.sheet(isPresented: $ispassrequier) {
						if counter.count == 1 {
							FullscreenImageView()
						}
						else if counter.count == 2 {
							TransactionView()
						} else {
							ConentErrorView()
						}
					}
				}.onAppear(perform: {
					self.text = ""
				})
			}
		} else {
			// Fallback on earlier versions
		}
	}
}



struct ConentErrorView: View {
	var body: some View {
		Text("Looks something went wrong!! please try again later")
	}
}
