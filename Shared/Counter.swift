//
//  Counter.swift
//  WatchConnectivityPrototype
//
//

import Foundation
import Combine
import WatchConnectivity

final class Counter: ObservableObject {
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<Int, Never>()
    
    @Published private(set) var count: Int = 0
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(countSubject: subject)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$count)
    }
    
	func increment(counts: Int) {
        count += 1
		if WCSession.isSupported() {
			session.sendMessage(["count": counts], replyHandler: nil) { error in
				print(error.localizedDescription)
			}
		}
    }
    
    func decrement() {
        count -= 1
		if WCSession.isSupported() {
			session.sendMessage(["count": count], replyHandler: nil) { error in
				print(error.localizedDescription)
			}
		}
    }
}
