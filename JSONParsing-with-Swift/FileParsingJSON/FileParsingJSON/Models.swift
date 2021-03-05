//
//  Models.swift
//  FileParsingJSON
//
//  Created by Joe Pham on 2021-03-05.
//

import Foundation

struct Result: Codable {
	let data: [ResultItem]
}

struct ResultItem: Codable {
	let title: String
	let items: [String]
}
