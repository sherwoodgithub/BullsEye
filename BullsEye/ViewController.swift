//
//  ViewController.swift
//  BullsEye
//
//  Created by Stephen on 12/8/14.
//  Copyright (c) 2014 Sherwood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Hit Me! button action and result
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        var title = ""
        
        if difference == 0 {
            title = "Perfect score! +100 bonus!"
            points += 100
        } else if difference < 5 {
            title = "So close!"
            if difference == 1 {
                title += " +50 bonus!"
                points += 50
            }
        } else if difference < 10 {
            title = "Not bad!"
        } else {
            title = "That wasn't even close."
        }
        
        score += points
        
        let message = "You got \(points) points!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Ok", style: .Default,
                                    handler: { action in
                                                self.startNewRound()
                                                self.updateLabels()
                                                })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    
    //Slider movement pushes a rounded new Int to currentValue
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
 
    // gets a random targetValue, sets currentValue @ 50, tells slider to go there
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
}

