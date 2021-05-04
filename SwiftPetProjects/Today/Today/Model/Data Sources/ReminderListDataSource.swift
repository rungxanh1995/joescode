//
//  ReminderListDataSource.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class ReminderListDataSource: NSObject {
	private lazy var dateFormatter = RelativeDateTimeFormatter()
	
	enum Filter: Int {
		case today
		case future
		case all
		
		func shouldInclude(date: Date) -> Bool {
			let isInToday = Locale.current.calendar.isDateInToday(date)
			switch self {
				case .today:
					return isInToday
				case .future:
					return (date > Date()) && !isInToday
				case .all:
					return true
			}
		}
	}
	
	var filter: Filter = .today
	
	var filteredReminders: [Reminder] {
		return Reminder.testData.filter { filter.shouldInclude(date: $0.dueDate) }.sorted { $0.dueDate < $1.dueDate }
	}
	
	func update(_ reminder: Reminder, at row: Int) {
		Reminder.testData[row] = reminder
	}
	
	func reminder(at row: Int) -> Reminder {
		return filteredReminders[row]
	}
	
	func add(_ reminder: Reminder) {
		Reminder.testData.insert(reminder, at: 0)
	}
}

extension ReminderListDataSource: UITableViewDataSource {
	static let reminderListCellIdentifier = "ReminderListCell"
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredReminders.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderListCellIdentifier, for: indexPath) as? ReminderListCell else {
			fatalError("Unable to dequeue ReminderCell")
		}
		let currentReminder = reminder(at: indexPath.row)
		let dateText = dateFormatter.localizedString(for: currentReminder.dueDate, relativeTo: Date())
		cell.configure(title: currentReminder.title, dateText: dateText, isDone: currentReminder.isComplete) {
			var modifiedReminder = currentReminder
			modifiedReminder.isComplete.toggle()
			self.update(modifiedReminder, at: indexPath.row)
			tableView.reloadRows(at: [indexPath], with: .none)
		}
		return cell
	}
}
