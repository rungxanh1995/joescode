//
//  ViewController.swift
//  Project2
//
//  Created by Joe Pham on 2021-01-06.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  // An array to hold country names
  var countries = [String]()
  // A var to hold player's current score
  var score = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // Fill up countries array with asset flags
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
    // Set borderWith of all buttons
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    // Set borderColor of all buttons
    // Include .cgColor to convert UIColor values -> CGColor to assign to borderColor of CALayer
    button1.layer.borderColor = UIColor(red: 0.86, green: 0.56, blue: 0.15, alpha: 1.00).cgColor
    button2.layer.borderColor = UIColor(red: 0.86, green: 0.56, blue: 0.15, alpha: 1.00).cgColor
    button3.layer.borderColor = UIColor(red: 0.86, green: 0.56, blue: 0.15, alpha: 1.00).cgColor
    
    // Call askQuestion() method
    askQuestion()
  }
  
  // Method to show 3 random flags in the 3 buttons
  func askQuestion() {
    button1.setImage(UIImage(named: countries[Int.random(in: 0..<countries.count)]), for: .normal)
    button2.setImage(UIImage(named: countries[Int.random(in: 0..<countries.count)]), for: .normal)
    button3.setImage(UIImage(named: countries[Int.random(in: 0..<countries.count)]), for: .normal)
  }


}

