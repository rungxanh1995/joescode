//
//  ViewController.swift
//  Project1
//
//  Created by Joe Pham on 2021-01-03.
//

import UIKit

class ViewController: UITableViewController {
  // A property to store filenames outside of viewDidLoad()
  // Let's set it as empty String array for now
  // It'd be an array for all "nssl" pics for later reference rather than having to re-read the resources directory again and again
  // It's a variable as it'd be changed by the for loop later
  var pictures = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let fm = FileManager.default
    // This lets us work with the filesystem, in this case looking for files
    
    let path = Bundle.main.resourcePath!
    // This sets to the resourcePath of this app's bundle
    // This literally says "Tell me where I can find all images I added to this app"
    // Force unwrapping here is safe as this app definitely has a resourcePath
    
    let items = try! fm.contentsOfDirectory(atPath: path)
    // This sets to the contents of directory at "path" above
    // "items" is an array of strings containing filenames
    
    // For loop iterates through each item found in the app contents
    for item in items {
      // Work in filenames that have prefix "nssl" only {
      if item.hasPrefix("nssl") {
        // Add that filename to the initial empty array
        pictures.append(item)
      }
    }
    // Print the filenames to debug console
    print(pictures)
  }
  
  // Set how many rows to appear in table view
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return length of array
    return pictures.count
  }
  
  // Specify how each row should look like
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Link to "Picture" in Main.storyboard
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    
    // Give text label of the cell the same value as a picture from the array
    // textLabel? optional chaining: "Execute only if there's an actual text label, otherwise do nothing"
    cell.textLabel?.text = pictures[indexPath.row]
    // indexPath.row contains the row number asked to low
    
    // Return the cell as a UITableViewCell to method
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // 1: Try loading "Detail" view controller & type casting it to be DetailViewController
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
      // 2: If success -> set selectedImage property of "vc"
      // "selectedImage" is declared as optional in DetailViewController.swift
      vc.selectedImage = pictures[indexPath.row]
      
      // 3: Now push it onto the navigation controller
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}


