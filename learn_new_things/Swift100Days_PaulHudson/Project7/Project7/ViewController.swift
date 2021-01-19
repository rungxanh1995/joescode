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
        
        // Enable large title of this view controller
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // If tabBarItem #0 is selected then
            title = "Recent Petitions"
            // Original URL for JSON petition file from the White House website
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            // Backup cached JSON on hackingwithswift.com
            // "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            title = "Popular Petitions"
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            // Backup cached JSON on hackingwithswift.com
            // "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
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
    
    // Method to alert users when data doesn't work properly
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was an unexpected issue loading the petitions feed. Please check your connection and try again later.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//        ac.addAction(UIAlertAction(title: "Reload", style: .default, handler: parse))
        present(ac, animated: true)
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
    
    // Link DetailViewController screen to current ViewController
    // without the need to add the screen in IB or via instantiation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

