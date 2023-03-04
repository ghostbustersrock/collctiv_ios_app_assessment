//
//  GameBrain.swift
//  ios_dev_application
//
//  Created by Luca Santarelli on 28/02/23.
//

import Foundation
import UIKit

struct GameBrain {
    
    var buttonGrid: [[UIButton]]?
    var label: UILabel?
    
    // horizontal == true ; vertical == false
    var previousDirection = true
    var currentPosition = (0, 0)
    var win = (1, 2)
    var won = false
    var forbidden = (0, 1)
    
    
    mutating func gameLogic(_ sender: UIButton) {
        
        var rowButton: Int?
        var columnButton: Int?
        
        outerLoop: for (row, buttons) in buttonGrid!.enumerated() {
            for button in buttons {
                if sender == button {
                    rowButton = row
                    columnButton = button.tag
                    break outerLoop
                }
            }
        }
        
        if let row = rowButton, let column = columnButton {
            
            if !won {
                
                if row == currentPosition.0 && column == currentPosition.1 {
                    updateLabel("You selected the same cell :(")
                }
                else if (row - currentPosition.0) > 1 || (column - currentPosition.1) > 1 {
                    updateLabel("You cannot move more than one space at a time!")
                }
                else if (currentPosition.0 + 1 == row || currentPosition.0 - 1 == row) && previousDirection && currentPosition.1 == column {
                    // Checking vertical movements
                    validityCell(row, column, "row")
                }
                else if (currentPosition.1 + 1 == column || currentPosition.1 - 1 == column) && !previousDirection && currentPosition.0 == row {
                    // Checking horizontal movements
                    validityCell(row, column, "col")
                }
                else {
                    updateLabel("You moved \(decodePosition()) previously!")
                }
            }
        }
    }
    
    
    mutating func validityCell(_ row: Int, _ column: Int, _ toUpdate: String) {
        if (row, column) == forbidden {
            updateLabel("Sorry you cannot go there!")
        }
        else if (row, column) == win {
            clearButton(currentPosition.0, currentPosition.1)
            updateGrid(row, column, "Congratulations you won!")
            won = true
        }
        else {
            clearButton(currentPosition.0, currentPosition.1)
            
            if toUpdate == "row" {
                currentPosition.0 = row
            } else {
                currentPosition.1 = column
            }
            
            previousDirection = !previousDirection
            
            let direction = decodePosition()
            
            updateGrid(row, column, "Moved \(direction)ly by 1")
        }
    }
    
    
    mutating func resetGame() {
        clearButton(win.0, win.1)
        currentPosition = (0,0)
        updateGrid(currentPosition.0, currentPosition.1, "Game has started!")
        previousDirection = true
        won = false
    }
    
    
    func updateGrid(_ row: Int, _ column: Int, _ msg: String) {
        updateLabel(msg)
        buttonGrid![row][column].backgroundColor = .blue
        buttonGrid![row][column].makeRound()
    }
    
    
    func clearButton(_ row: Int, _ column: Int) {
        buttonGrid![row][column].backgroundColor = .clear
    }
    
    
    func decodePosition() -> String {
        return previousDirection ? "horizontal" : "vertical"
    }
    
    
    func updateLabel(_ msg: String) {
        
        if let label = label {
            label.text = msg
        }
    }
}
