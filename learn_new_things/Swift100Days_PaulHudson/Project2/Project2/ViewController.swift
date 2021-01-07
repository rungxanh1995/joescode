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
  // A var to track the correct answer
  var correctAnswer = 0
  
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
  // Take in a nil UIAlertAction as initial value
  // But later the param value is updated in @IBAction's buttonTapped method below
  func askQuestion(action: UIAlertAction! = nil) {
    // Shuffle the country names array
    countries.shuffle()
    
    // Set image for each button as first 3 items of shuffled array
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    
    // Randomize the correct answer within the bounds of first 3 items
    correctAnswer = Int.random(in: 0...2)
    
    // Set title of ViewController to current correct answer index in the array
    title = countries[correctAnswer].uppercased()
  }

  @IBAction func buttonTapped(_ sender: UIButton) {
    // Declare a separate title property for button tapped action
    var title: String
    
    // Update value of title & score
    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
    } else {
      title = "Wrong"
      score -= 1
    }
    
    // Create a UIAlertController object constant as an alert
    let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
    // Add alert option to continue (call askQuestion) when the alert is show
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    // Present the alert on screen when a button is tapped
    self.present(ac, animated: true)
  }
}

