//
//  ViewController.swift
//  Project8
//
//  Created by Joe Pham on 2021-01-20.
//

import UIKit

class ViewController: UIViewController {

    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    override func loadView() {
        // Create initial, top root view
        view = UIView()
        view.backgroundColor = .white
        
        // Define the scoreLabel
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        // Define the cluesLabel
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0    // as many as it needs
        view.addSubview(cluesLabel)
        
        // Define the answersLabel
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0  // as many as it needs
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
        
        // Lower content hugging priority of cluesLabel & answersLabel
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        // Define the currentAnswer
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false  // disable keyboard
        view.addSubview(currentAnswer)
        
        // Create a Submit button
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        view.addSubview(submitButton)
        
        // Create a Clear button
        let clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        view.addSubview(clearButton)
        
        // Create a UIView to host the word buttons
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        

        // Activate at the same time an array of constraints
        NSLayoutConstraint.activate([
            // pin top of scoreLabel to top of layout margins guide
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            // pin trailing edge of scoreLabel to that of layout margins guide
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // pin top of cluesLabel to bottom of scoreLabel
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // pin leading edge of cluesLabel to that of layout margins with indent
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            // allow cluesLabel to take up 60% of the layout margins width with negative indent to account for the above constraint
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            // pin top of answersLabel to bottom of scoreLabel
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // pin trailing edge of answersLabel to that of layout margins with negative indent
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            // allow answersLabel to take up remaining 40% of layout margins width with negative indent too
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            // match height of answersLabel to cluesLabel's
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            // align currentAnswer horizontally
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // allow currentAnswer to take up half of view width
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            // pin currentAnswer to bottom of cluesLabel with indent
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            // pin top of submit button to bottom of currentAnswer
            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 20),
            // push submit button a bit off the view center horizontally to the left
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            // force tappable size of submit button to adhere Apple's Human Design Guidelines
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            
            // let vertical position of clear button similar to that of submit button
            clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            // push clear button a bit off the view center horizontally to the right
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            // force tappable size of clear button to adhere to Apple's Human Design Guidelines
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            
            // set area sizing of buttonsView
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            // center buttonsView horizontally
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // pin top of buttonsView to bottom of submit button with spacing
            buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            // pin bottom of buttonsView to bottom of view with spacing
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        // End of constraints array
 
        // Define attributes to each word button
        let buttonWidth = 150
        let buttonHeight = 80
        
        // Define max index of button rows & columns to loop through
        let maxButtonRowIndex = 3
        let maxButtonColumnIndex = 4
        
        // Create the grid of 4x5 word buttons
        for row in 0...maxButtonRowIndex {
            for column in 0...maxButtonColumnIndex {
                // Create a button and set font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                // Give each button some default text for testing
                letterButton.setTitle("ABC", for: .normal)
                
                // Calculate the button frame using its column & row
                let buttonFrame = CGRect(x: column * buttonWidth, y: row * buttonHeight, width: buttonWidth, height: buttonHeight)
                letterButton.frame = buttonFrame
                
                // Add the button to buttonsView
                buttonsView.addSubview(letterButton)
                
                // Also add the button to array letterButtons
                letterButtons.append(letterButton)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

