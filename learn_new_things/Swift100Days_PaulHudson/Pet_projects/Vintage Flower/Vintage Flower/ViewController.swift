//
//  ViewController.swift
//  Vintage Flower
//
//  Created by Joe Pham on 2021-02-14.
//

import UIKit

class ViewController: UITableViewController {
    
    var flowers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Vintage Flowers 🌺"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        

        DispatchQueue.global().async { [weak self] in
            for item in items {
                if item.hasPrefix("flower") {
                    self?.flowers.append(item)
                }
            }
            self?.flowers.sort()
        }

        tableView.reloadData()
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            vc.selectedImage = flowers[indexPath.row]
            vc.selectedPosition = indexPath.row + 1
            vc.totalNumberOfImages = flowers.count
            
            navigationController?.pushViewController(vc, animated: true)
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
