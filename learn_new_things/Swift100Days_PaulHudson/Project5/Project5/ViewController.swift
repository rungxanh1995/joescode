//
//  ViewController.swift
//  Project5: Anagram Word Game
//
//  Created by Joe Pham on 2021-01-12.
//

import UIKit

class ViewController: UITableViewController {
    // 1st array to hold all game words from input file "start.txt"
    var allWords = [String]()
    // 2nd array to hold all words the player has used in this game
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Add an "add" button where once tapped the player can input their anagram answer
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        // Find URL path to "start.txt" file in the filesystem
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Create a string from all text contents of the input file
            // Use "try?" to show if the code throws an error, return nil instead
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Break down this string into words at each "\n"
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        // But even if "try?" returns nil, we have a backup here for allWords
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        // Start the game
        startGame()
    }

    // Main game method
    func startGame() {
        // Show title as 1 random word in the 1st array
        // Also the word the player has to find
        title = allWords.randomElement()
        
        usedWords.removeAll(keepingCapacity: true)
        
        // Call table view's reloadData() to force call numberOfRowsInSection again
        // Also it calls cellForRowAt repeatedly -> all to check if data loaded correctly
        tableView.reloadData()
    }
    
    // Foundation methods to handle table view data
    // 1. numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    // 2. cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    // Method to allow user input of the word they guess
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        // Add a textbox for user to input the answer
        // Also means adding a UITextField instance
        ac.addTextField()
        
        // Define submitAction as a UIAlertAction with a trailing closure syntax for its param "handler"
        // code for "handler" is between { }
        // also using weak capture list for the current view controller as "self" and the "ac" above
        // as the code will use "self" and "ac" & Swift would default to strong reference cycle
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            // This closure can only call submit() if it captures the view controller
            // and "self" was also declared as weak referencing, hence "self?"
            self?.submit(answer)
        }
        // Add submitAction to this UIAlertController "ac"
        ac.addAction(submitAction)
        self.present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
    }
}

