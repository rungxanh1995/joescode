//
//  ViewController.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class ReminderListViewController: UITableViewController {
	@IBOutlet var filterSegmentedControl: UISegmentedControl!
	
	private var reminderListDataSource: ReminderListDataSource?
	private var filter: ReminderListDataSource.Filter {
		return ReminderListDataSource.Filter(rawValue: filterSegmentedControl.selectedSegmentIndex) ?? .today
	}
	
	static let showDetailSegueIdentifier = "ShowReminderDetailSegue"
	static let mainStoryboardName = "Main"
	static let detailViewControllerIdentifier = "ReminderDetailViewController"
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Self.showDetailSegueIdentifier,
		   let destination = segue.destination as? ReminderDetailViewController,
		   let cell = sender as? UITableViewCell,
		   let indexPath = tableView.indexPath(for: cell) {
			let rowIndex = indexPath.row
			guard let reminder = reminderListDataSource?.reminder(at: rowIndex) else {
				fatalError("Couldn't find data source for reminder list")
			}
			destination.configure(with: reminder, editAction: { reminder in
				self.reminderListDataSource?.update(reminder, at: rowIndex)
				self.tableView.reloadData()
			})
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		reminderListDataSource = ReminderListDataSource()
		tableView.dataSource = reminderListDataSource
	}
	
	@IBAction func addButtonTriggered(_ sender: UIBarButtonItem) {
		addReminder()
	}
	
	@IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
		reminderListDataSource?.filter = filter
		tableView.reloadData()
	}
	
	private func addReminder() {
		let storyboard = UIStoryboard(name: Self.mainStoryboardName, bundle: nil)
		let detailViewController: ReminderDetailViewController = storyboard.instantiateViewController(identifier: Self.detailViewControllerIdentifier)
		let reminder = Reminder(id: UUID().uuidString, title: "New Reminder", dueDate: Date())
		detailViewController.configure(with: reminder, isNew: true, addAction: { reminder in
			if let index = self.reminderListDataSource?.add(reminder) {
			self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
			}
		})
		let navigationController = UINavigationController(rootViewController: detailViewController)
		present(navigationController, animated: true, completion: nil)
	}
}


