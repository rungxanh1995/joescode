//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
	
	private var reminder: Reminder?
	private var dataSource: UITableViewDataSource?
	
	func configure(with reminder: Reminder) {
		self.reminder = reminder
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setEditing(false, animated: false)
		navigationItem.setRightBarButton(editButtonItem, animated: false)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		guard let reminder = reminder else {
			fatalError("No reminder found for detail view")
		}
		if editing {
			dataSource = ReminderDetailEditDataSource(reminder: reminder, changeAction: { reminder in
				self.editButtonItem.isEnabled = true
			})
			navigationItem.title = NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
			navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTriggered))
		} else {
			dataSource = ReminderDetailViewDataSource(reminder: reminder)
			navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
			navigationItem.leftBarButtonItem = nil
			editButtonItem.isEnabled = true
		}
		tableView.dataSource = dataSource
		tableView.reloadData()
	}
	
	@objc
	func cancelButtonTriggered() {
		setEditing(false, animated: true)
	}
}


