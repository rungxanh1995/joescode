//
//  ViewController.swift
//  Project7
//
//  Created by Joe Pham on 2021-01-17.
//

import UIKit

class ViewController: UITableViewController {
    
    // An array to store Petition instances defined in Petition.swift
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Original URL for JSON petition file from the White House website
         let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        // Cached JSON on hackingwithswift.com
        // let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            // Parse the converted JSON results content into array "petitions"
            petitions = jsonPetitions.results
            // Tell tableView to reload itself
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
}

