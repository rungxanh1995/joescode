//
//  EditTitleCell.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class EditTitleCell: UITableViewCell {
	@IBOutlet var titleTextField: UITextField!
	
	func configure(title: String) {
		titleTextField.text = title
	}
}
