//
//  ReminderListDataSource.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit
import EventKit

class ReminderListDataSource: NSObject {
	typealias ReminderCompletedAction = (Int) -> Void
	typealias ReminderDeletedAction = () -> Void
	
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
		return reminders.filter { filter.shouldInclude(date: $0.dueDate) }.sorted { $0.dueDate < $1.dueDate }
	}
	
	var percentComplete: Double {
		guard filteredReminders.count > 0 else { return 1 }
		let numComplete: Double = filteredReminders.reduce(0) { $0 + ($1.isComplete
			? 1 : 0) }
		return numComplete / Double(filteredReminders.count)
	}
	
	private let eventStore = EKEventStore()
	
	private var reminders: [Reminder] = []
	private var reminderCompletedAction: ReminderCompletedAction?
	private var reminderDeletedAction: ReminderDeletedAction?
	
	init(reminderCompletedAction: @escaping ReminderCompletedAction, reminderDeletedAction: @escaping ReminderDeletedAction) {
		self.reminderCompletedAction = reminderCompletedAction
		self.reminderDeletedAction = reminderDeletedAction
		super.init()
	}
	
	func update(_ reminder: Reminder, at row: Int) {
		let index = self.index(for: row)
		reminders[index] = reminder
	}
	
	func delete(at row: Int) {
		let index = self.index(for: row)
		reminders.remove(at: index)
	}
	
	func reminder(at row: Int) -> Reminder {
		return filteredReminders[row]
	}
	
	func add(_ reminder: Reminder) -> Int? {
		reminders.insert(reminder, at: 0)
		return filteredReminders.firstIndex(where: { $0.id == reminder.id })
	}
	
	func index(for filteredIndex: Int) -> Int {
		let filteredReminder = filteredReminders[filteredIndex]
		guard let index = reminders.firstIndex(where: { $0.id == filteredReminder.id }) else {
			fatalError("Couldn't retrieve index in source array")
		}
		return index
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
		let dateText = currentReminder.dueDateTimeText(for: filter)
		cell.configure(title: currentReminder.title, dateText: dateText, isDone: currentReminder.isComplete) {
			var modifiedReminder = currentReminder
			modifiedReminder.isComplete.toggle()
			self.update(modifiedReminder, at: indexPath.row)
			self.reminderCompletedAction?(indexPath.row)
			tableView.reloadRows(at: [indexPath], with: .none)
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		delete(at: indexPath.row)
		tableView.performBatchUpdates {
			tableView.deleteRows(at: [indexPath], with: .automatic)
		} completion: { _ in
			tableView.reloadData()
		}
		reminderDeletedAction?()
	}
}

extension Reminder {
	static let timeFormatter: DateFormatter = {
		let timeFormatter = DateFormatter()
		timeFormatter.dateStyle = .none
		timeFormatter.timeStyle = .short
		return timeFormatter
	}()
	
	static let futureDateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .short
		return dateFormatter
	}()
	
	static let todayDateFormatter: DateFormatter = {
		let format = NSLocalizedString("'Today at '%@", comment: "format string for dates occurring today")
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = String(format: format, "hh:mm a")
		return dateFormatter
	}()
	
	func dueDateTimeText(for filter: ReminderListDataSource.Filter) -> String {
		let isInToday = Locale.current.calendar.isDateInToday(dueDate)
		switch filter {
			case .today:
				return Self.timeFormatter.string(from: dueDate)
			case .future:
				return Self.futureDateFormatter.string(from: dueDate)
			case .all:
				if isInToday {
					return Self.todayDateFormatter.string(from: dueDate)
				} else {
					return Self.futureDateFormatter.string(from: dueDate)
				}
		}
	}
}

extension ReminderListDataSource {
	private var isAvailable: Bool {
		EKEventStore.authorizationStatus(for: .reminder) == .authorized
	}
	
	private func requestAccess(completion: @escaping (Bool) -> Void) {
		let currentStatus = EKEventStore.authorizationStatus(for: .reminder)
		guard currentStatus == .notDetermined else {
			completion(currentStatus == .authorized)
			return
		}
		eventStore.requestAccess(to: .reminder) { success, error in
			completion(success)
		}
	}
	
	private func readAllReminders() {
		guard isAvailable else { return }
		let predicate = eventStore.predicateForReminders(in: nil)
		eventStore.fetchReminders(matching: predicate) { ekReminders in
			guard let ekReminders = ekReminders else {
				self.reminders = []
				return
			}
			self.reminders = ekReminders.compactMap { sourceReminder in
				guard let dueDate = sourceReminder.alarms?.first?.absoluteDate else { return nil }
				let newReminder = Reminder(id: sourceReminder.calendarItemIdentifier,
										   title: sourceReminder.title,
										   dueDate: dueDate,
										   notes: sourceReminder.notes,
										   isComplete: sourceReminder.isCompleted)
				return newReminder
			}
		}
	}
}
