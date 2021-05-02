//
//  Utils.swift
//  Tic Tac Toe
//
//  Created by Joe Pham on 2021-05-02.
//

import SwiftUI

struct AlertItem: Identifiable {
	let id = UUID()
	var title: Text
	var message: Text
	var buttonTitle: Text
}

struct AlertContext {
	static let humanWin 	= AlertItem(title: Text("You Win!"),
										message: Text("You outsmarted technology"),
										buttonTitle: Text("Hell yeah"))
	
	static let computerWin 	= AlertItem(title: Text("You Lost"),
										   message: Text("Good luck next time buddy"),
										   buttonTitle: Text("Rematch"))
	
	static let draw 		= AlertItem(title: Text("Draw"),
										message: Text("What a battle of wits!"),
										buttonTitle: Text("Try Again"))
}

extension GameView {
	func hapticOnTap() {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(.success)
	}
}

