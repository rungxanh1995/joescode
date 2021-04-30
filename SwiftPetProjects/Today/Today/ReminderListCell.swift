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
	
	var doneButtonAction: DoneButtonAction?
	
	@IBAction func doneButtonTriggered(_ sender: UIButton) {
		
	}
}
