//
//    ViewController.swift
//    Project1
//
//    Created by Joe Pham on 2021-01-03.
//

import UIKit

class ViewController: UICollectionViewController {
    var storms = [Storm]()
    
    // MAINLINE VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            for item in items {
                if item.hasPrefix("nssl") {
                    let storm = Storm(name: item, image: UIImage(contentsOfFile: item)!)
                    self?.storms.append(storm)
//                    self?.storms.sort()
                }
            }
        }
        
    }
    
    // NUMBER OF ITEMS IN SECTION
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storms.count
    }
    
    // CELL FOR ITEM AT
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? StormCell else {
                // we failed to get a PersonCell – bail out!
                fatalError("Unable to dequeue PersonCell.")
            }
        
        let storm = storms[indexPath.item] // a specific Storm object in the people array
        cell.name.text = storm.name
        
        cell.imageView?.image = UIImage(named: storm.name)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    // DID SELECT ITEM AT -> ENTER DETAIL VIEW CONTROLLER
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storm = storms[indexPath.item]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = storm.name
            
            // For the title of the detail view
            vc.selectedImagePosition = indexPath.item + 1   // show human-readable position number
            vc.totalNumberOfImages = storms.count
            
            navigationController?.pushViewController(vc, animated: true)    // push to detail view controller
        }
    }
    
    
    // SHARE APP TO OTHERS
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Check out this awesome Storm Viewer"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
