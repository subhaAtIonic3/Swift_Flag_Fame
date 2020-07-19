//
//  ViewController.swift
//  Project2_Swift_iOS
//
//  Created by Subhrajyoti Chakraborty on 23/05/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareScoreTapped))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button2.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        questionAnswered += 1
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased())"
        
    }
    
    func saveHighestScore(action: UIAlertAction) {
        let defaults = UserDefaults.standard
        let highestScore = defaults.integer(forKey: "highestScore")
        print(highestScore)
        
        
        let title = highestScore < score ? (highestScore != 0 ? "You beat your highest score!!" : "Your new highest score \(score)") : "Current Score \(score)"
        let message = highestScore < score ? "Your new highest score is \(score)" : "Your highest score is \(highestScore)"
    
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: resetGame))
        present(ac, animated: true)
    }
    
    func resetGame(action: UIAlertAction) {
        let defaults = UserDefaults.standard
        let highestScore = defaults.integer(forKey: "highestScore")
        if highestScore < score {
            defaults.set(score, forKey: "highestScore")
        }
        
        score = 0
        questionAnswered = 0
        askQuestion()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if correctAnswer == sender.tag {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        print(questionAnswered, score)
        var ac: UIAlertController
        
        if questionAnswered == 10 {
            ac = UIAlertController(title: "You have answered ten questions", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: saveHighestScore))
        } else {
            ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        
        
        present(ac, animated: true)
    }
    
    @objc func shareScoreTapped() {
        let defaults = UserDefaults.standard
        let highestScore = defaults.integer(forKey: "highestScore")
        
        let ac = UIAlertController(title: "Your highest score", message: "\(highestScore)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

