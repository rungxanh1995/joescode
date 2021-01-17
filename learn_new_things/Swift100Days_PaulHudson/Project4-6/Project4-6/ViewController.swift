//
//  ViewController.swift
//  Project4-6
//
//  Created by Joe Pham on 2021-01-17.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startNewList))
        
        startNewList()
    }
    
    // Initial method - also from left bar buttom item - to start new list
    @objc func startNewList() {
        title = title
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    // Method from right bar button item to show prompt for new shopping item
    @objc func promptForItem() {
        let ac = UIAlertController(title: "New shopping item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addItem = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] (action) in
            guard let item = ac?.textFields?[0].text else { return }
            self?.addItem(item)
        }
        
        ac.addAction(addItem)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true)
    }
    
    // Method to add new shopping item to list
    func addItem(_ item: String) {
        let itemToAdd = item
        // Add item to shoppingList array first
        shoppingList.insert(itemToAdd, at: 0)
        // Then add it to table view controller
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }

    
    // Define table view controller rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    // Define how each table view cell looks like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

