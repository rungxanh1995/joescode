//
//  Utils.swift
//  Today
//
//  Created by Joe Pham on 2021-05-10.
//

import UIKit

extension ReminderListViewController {
	func hapticOnUIElements() {
		// haptic when tapping UI controls of the app
		let generator = UISelectionFeedbackGenerator()
		generator.selectionChanged()
	}
	
	func hapticOnCompleteReminders() {
		// haptic when toggling the Done button of a reminder
		let generator = UIImpactFeedbackGenerator(style: .medium)
		generator.impactOccurred()
	}
}

struct AlertItem: Identifiable {
	let id = UUID()
	var title: String
	var message: String
	var actionTitle: String
}

struct AlertContext {
	static let errorUpdatingRemindersAlert = AlertItem(title: "Can't Update Reminders",
													   message: "An error occured while attempting to update the reminder.",
													   actionTitle: "OK")
}
