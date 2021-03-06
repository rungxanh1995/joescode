//
//  ViewController.swift
//  Vintage Flower
//
//  Created by Joe Pham on 2021-02-14.
//

import UIKit

class ViewController: UITableViewController {
    
    var flowers = [String]()
	var flowerViewsCount = [String: Int]()
	
	let mainQueue = DispatchQueue.main
	let globalQueue = DispatchQueue.global()
	let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Vintage Flowers 🌺"
        navigationController?.navigationBar.prefersLargeTitles = true
        
		globalQueue.async { [weak self] in
			self?.loadImages()
		}
		
		// UNPACK LAST SAVED IMAGE VIEW COUNT
		flowerViewsCount = defaults.object(forKey: "SavedCount") as? [String: Int] ?? [String: Int]()

        tableView.reloadData()
    }
	
	func loadImages() {
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
		
		for item in items {
			if item.hasPrefix("flower") {
				flowers.append(item)
			}
		}
		flowers.sort()
	}
	
	// METHOD TO SAVE USERDEFAULTS DATA
	func saveViewsCount() {
		defaults.set(flowerViewsCount, forKey: "SavedCount")
	}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerCell", for: indexPath)
        
        // Define the image name for each cell
        let firstImageName = String(flowers[indexPath.row].getFileName().split(separator: ".")[0].dropFirst(6)) // get the 1st item from the split array
        let lastImageName = String(flowers[indexPath.row].getFileName().dropFirst(9))
        let imageName = "\(firstImageName).\t\(lastImageName)"
		
        cell.textLabel?.text = imageName
		cell.detailTextLabel?.text = "Views: \(flowerViewsCount[flowers[indexPath.row], default: 0])"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            vc.selectedImage = flowers[indexPath.row]
            vc.selectedPosition = indexPath.row + 1
            vc.totalNumberOfImages = flowers.count
			
			flowerViewsCount[flowers[indexPath.row], default: 0] += 1	// add value to the dict
			
			globalQueue.async { [weak self] in
				self?.saveViewsCount()
				
				self?.mainQueue.async {
					self?.navigationController?.pushViewController(vc, animated: true)
					self?.tableView.reloadRows(at: [indexPath], with: .none)	// update views count live
				}
			}
        }
    }
}


extension String {
  func getFileName() -> String {
    return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
  }
  
  func getFileExtension() -> String {
    return URL(fileURLWithPath: self).pathExtension
  }
}
