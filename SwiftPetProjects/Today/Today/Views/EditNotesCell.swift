//
//  EditNotesCell.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import UIKit

class EditNotesCell: UITableViewCell {
	@IBOutlet var notesTextView: UITextView!
	
	func configure(notes: String?) {
		notesTextView.text = notes
	}
}
