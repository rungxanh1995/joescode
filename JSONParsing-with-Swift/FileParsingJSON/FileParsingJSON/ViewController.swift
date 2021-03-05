//
//  ViewController.swift
//  FileParsingJSON
//
//  Created by Joe Pham on 2021-03-05.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var result: Result?
	
	// MARK: - Child tableView
	private let tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return table
	}()
	
	// MARK: - viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		parseJSON()
		
		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	// MARK: - TableView Functions
	func numberOfSections(in tableView: UITableView) -> Int {
		return result?.data.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return result?.data[section].title
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let result = result {
			return result.data[section].items.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let text = result?.data[indexPath.section].items[indexPath.row]
		cell.textLabel?.text = text
		return cell
	}

	// MARK: - JSON Parsing
	private func parseJSON() {
		guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return }
		
		let url = URL(fileURLWithPath: path)

		do {
			let jsonData = try Data(contentsOf: url)
			result = try JSONDecoder().decode(Result.self, from: jsonData)
			
			return
		}
		catch {
			print("Error: \(error.localizedDescription)")
		}
	}
}
