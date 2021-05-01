//
//  EditDateCell.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class EditDateCell: UITableViewCell {
	@IBOutlet var datePicker: UIDatePicker!
	
	func configure(date: Date) {
		datePicker.date = date
	}
}
