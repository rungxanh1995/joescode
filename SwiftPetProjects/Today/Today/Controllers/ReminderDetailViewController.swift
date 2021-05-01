//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
	
	private var reminder: Reminder?
	private var detailViewDataSource: ReminderDetailViewDataSource?
	
	func configure(with reminder: Reminder) {
		self.reminder = reminder
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let reminder = reminder else {
			fatalError("No reminder found for detail view")
		}
		detailViewDataSource = ReminderDetailViewDataSource(reminder: reminder)
		tableView.dataSource = detailViewDataSource
	}
}


