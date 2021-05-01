//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
	typealias ReminderChangeAction = (Reminder) -> Void
	
	private var reminder: Reminder?
	private var tempReminder: Reminder?
	private var dataSource: UITableViewDataSource?
	private var reminderEditAction: ReminderChangeAction?
	private var reminderAddAction: ReminderChangeAction?
	private var isNew = false
	
	func configure(with reminder: Reminder, isNew: Bool = false, addAction: ReminderChangeAction? = nil, editAction: ReminderChangeAction? = nil) {
		self.reminder = reminder
		self.isNew = isNew
		self.reminderAddAction = addAction
		self.reminderEditAction = editAction
		if isViewLoaded {
			setEditing(isNew, animated: false)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setEditing(isNew, animated: false)
		navigationItem.setRightBarButton(editButtonItem, animated: false)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
	}
	
	fileprivate func transitionToEditMode(_ reminder: Reminder) {
		dataSource = ReminderDetailEditDataSource(reminder: reminder, changeAction: { reminder in
			self.tempReminder = reminder
			self.editButtonItem.isEnabled = true
		})
		navigationItem.title = isNew ? NSLocalizedString("Add Reminder", comment: "add reiminder nav title") :  NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTriggered))
	}
	
	fileprivate func transitionToViewMode(_ reminder: Reminder) {
		if isNew {
			let addReminder = tempReminder ?? reminder
			dismiss(animated: true) {
				self.reminderAddAction?(addReminder)
			}
			return
		}
		if let tempReminder = tempReminder {
			self.reminder = tempReminder
			self.tempReminder = nil
			reminderEditAction?(tempReminder)
			dataSource = ReminderDetailViewDataSource(reminder: tempReminder)
		} else {
			dataSource = ReminderDetailViewDataSource(reminder: reminder)
		}
		navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
		navigationItem.leftBarButtonItem = nil
		editButtonItem.isEnabled = true
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		guard let reminder = reminder else {
			fatalError("No reminder found for detail view")
		}
		if editing {
			transitionToEditMode(reminder)
		} else {
			transitionToViewMode(reminder)
		}
		tableView.dataSource = dataSource
		tableView.reloadData()
	}
	
	@objc
	func cancelButtonTriggered() {
		if isNew {
			dismiss(animated: true, completion: nil)
		} else {
			tempReminder = nil
			setEditing(false, animated: true)
		}
	}
}


