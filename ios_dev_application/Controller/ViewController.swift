//
//  ViewController.swift
//  ios_dev_application
//
//  Created by Luca Santarelli on 27/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var row1Buttons: [UIButton]!
    @IBOutlet var row2Buttons: [UIButton]!
    @IBOutlet var row3Buttons: [UIButton]!
    
    @IBOutlet weak var resetGameButton: UIButton!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    
    var gameBrain = GameBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetGameButton.isHidden = true
        hintLabel.text = "Game has started!"
        gameBrain.label = hintLabel
        gameBrain.buttonGrid = [row1Buttons, row2Buttons, row3Buttons]
        
        gameBrain.resetGame()
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        gameBrain.gameLogic(sender)
        resetGameButton.isHidden = !gameBrain.won
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        print("Game resetted")
        
        gameBrain.resetGame()
        
        resetGameButton.isHidden = true
    }
}


extension UIButton {
    func makeRound() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
