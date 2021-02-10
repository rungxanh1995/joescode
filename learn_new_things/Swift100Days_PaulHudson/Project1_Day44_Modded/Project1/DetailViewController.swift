//
//  DetailViewController.swift
//  Project1
//
//  Created by Joe Pham on 2021-01-04.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  
  var selectedImage: String?

  var selectedImagePosition: Int = 0
  var totalNumberOfImages: Int = 0
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    title = "Image \(selectedImagePosition) of \(totalNumberOfImages)"
    navigationItem.largeTitleDisplayMode = .never

    if let imageToLoad = selectedImage {
      // If success -> place imageToLoad into UIImage
      // then assign that to "image" property of "imageView" declared above
      imageView.image = UIImage(named: imageToLoad)
    }
  }
    
  // Hide bars on tap before the picture's view controller about to be shown
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  // Aka not hide bars on tap in the main view controller
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
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
