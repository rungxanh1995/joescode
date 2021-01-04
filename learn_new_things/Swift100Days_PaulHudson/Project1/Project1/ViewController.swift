//
//  ViewController.swift
//  Project1
//
//  Created by Joe Pham on 2021-01-03.
//

import UIKit

class ViewController: UITableViewController {
  // A property to store filenames outside of viewDidLoad()
  // Let's set it an empty [String] array for now
  // It'd be array of all "nssl" pics for later reference rather than having to re-read the resources directory again & again
  // It's a variable as it'd changed inside the for loop below
  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let fm = FileManager.default
    // This lets us work with the filesystem, in this case looking for files
    let path = Bundle.main.resourcePath!
    // This sets to the resourcePath of this app's bundle
    // It literally says "Tell me where I can find all images I added to this app"
    // Force unwrapping here is safe as this app definitely has a resourcePath
    let items = try! fm.contentsOfDirectory(atPath: path)
    // This sets to the contents of directory at "path"
    // "items" is an array of strings containing filenames
    
    for item in items {
      // This for loop executes once for each item found in the app bundle
      
      // Work on filenames that has prefix "nssl" only
      if item.hasPrefix("nssl") {
        // Add that filename to "pictures" array
        pictures.append(item)
      }
    }
    // Print "nssl" filenames in console window
    print(pictures)
  }
  
  // Set how many rows to appear in tableView
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
    return pictures.count
  }
  
  // Specify what each row should look like
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Link to "Picture" in Main.storyboard
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    // Give text label of the cell the same text as a picture in array "pictures"
    // textLabel? optional chaining: "execute only if there's an actual text label, otherwise do nothing"
    cell.textLabel?.text = pictures[indexPath.row]
    // indexPath.row contains the row number asked to load
    return cell
    // This returns the cell as a UITableViewCell
  }
}


