//
//  ReminderListCell.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class ReminderListCell: UITableViewCell {
	typealias DoneButtonAction = () -> Void
	
	@IBOutlet var doneButton: UIButton!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var dateLabel: UILabel!
	
	private var doneButtonAction: DoneButtonAction?
	
	@IBAction func doneButtonTriggered(_ sender: UIButton) {
		doneButtonAction?()
	}
	
	func configure(title: String, dateText: String, isDone: Bool, doneButtonAction: @escaping DoneButtonAction) {
		titleLabel.text = title
		dateLabel.text = dateText
		let image = isDone ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
		doneButton.setBackgroundImage(image, for: .normal)
		self.doneButtonAction = doneButtonAction
	}
}
