//
//  Models.swift
//  Relearn Project 7
//
//  Created by Joe Pham on 2021-03-05.
//

import Foundation

// MARK: - JSON MODELS
struct Petition : Codable {
	let id : String?
	let title : String?
	let body : String?
	let signatureThreshold : Int?
	let signatureCount : Int?
	let signaturesNeeded : Int?
	let url : String?
}

struct Petitions: Codable {
	let results: [Petition]
}
