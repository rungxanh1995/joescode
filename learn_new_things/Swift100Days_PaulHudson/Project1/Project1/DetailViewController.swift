//
//  DetailViewController.swift
//  Project1
//
//  Created by Joe Pham on 2021-01-04.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  // Force unwrapping/IUO here is valid, tho it's initially nil
  // But by the time it's used, UIImageView gets loaded & the outlet gets connected, UIImageView would point to a real UIImageView
  
  // Create a var to hold name of the image to load (as optional initially)
  var selectedImage: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      if let imageToLoad = selectedImage {
        // If success -> place imageToLoad into UIImage
        // then assign that to "image" property of "imageView" declared above
        imageView.image = UIImage(named: imageToLoad)
      }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
