//
//  Reminder.swift
//  Today
//
//  Created by Joe Pham on 2021-04-30.
//

import Foundation

struct Reminder {
	var id: String
	var title: String
	var dueDate: Date
	var notes: String? = nil
	var isComplete: Bool = false
}
