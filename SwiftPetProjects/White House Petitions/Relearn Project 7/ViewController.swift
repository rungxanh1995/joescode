//
//  ViewController.swift
//  Relearn Project 7
//
//  Created by Joe Pham on 2021-03-05.
//

import UIKit

// MARK: - Main vars/const
let mainQueue = DispatchQueue.main
let globalQueue = DispatchQueue.global()

var petitions = [Petition]()

// MARK: - Root view controller
class ViewController: UITableViewController {

	// MARK: - viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Recent Petitions"
		navigationController?.navigationBar.prefersLargeTitles = true

		/*
		// MARK: - Parsing with an HTTP URL
		let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"


		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				globalQueue.async { [weak self] in
					self?.parseJSON(from: data)
				}
			}
		}
		*/
		
		globalQueue.async { [weak self] in
			self?.parseJSON()
		}
		
		tableView.reloadData()
	}
	
	// MARK: - tableView functions
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petitions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		cell.textLabel?.text = petitions[indexPath.row].title
		cell.detailTextLabel?.text = petitions[indexPath.row].body
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			vc.detailItem = petitions[indexPath.row]	// create the Petition object for the row
			navigationController?.pushViewController(vc, animated: true)
		}
	}

	// MARK: JSON Parsing
	/*
	MARK: - Parsing with an HTTP URL
	func parseJSON(from data: Data) {
		if let decodedPetitions = try? JSONDecoder().decode(Petitions.self, from: data) {
			petitions = decodedPetitions.results
		}
	}
	*/

	func parseJSON() {
		guard let path = Bundle.main.path(forResource: "petitions", ofType: "json") else { return }
		
		let url = URL(fileURLWithPath: path)
		
		do {
			let jsonData = try Data(contentsOf: url)
			let decodedPetitions = try JSONDecoder().decode(Petitions.self, from: jsonData)
			petitions = decodedPetitions.results
			return
		}
		catch {
			print("Error: \(error.localizedDescription)")
		}
	}
}

