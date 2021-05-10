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
