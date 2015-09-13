
//
//  SimonGameGenerator.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/3/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//

import Foundation

protocol SimonGameProtocol {
    
    func didWinTheGame()
    func didLostTheGame()
    func playButtons(start : Int, position : Int, colors : [SimonColor])
    
}

// This file purpose is to hold a single Simon Game
// Every time the user starts a new game a new instance of this class should be created.
// The idea is to replace the current instance with a new one.
class SimonGame {
    
    static let HighlightTime = 1.0
    
    var delegate : SimonGameProtocol?
    
    // The default number of colors the user needs to
    // get right to win the game
    let defaultLevel = 12
    
    // Holds which level is the player playing
    var currentLevel = 0
    
    var currentPress = 0
    
    // Holds the colors that will represent this game
    var colors = [SimonColor]()
    
    required init(delegate : SimonGameProtocol) {
        self.delegate = delegate
    }
    
    func startGame() {
        print("Starting game...")
        for _ in 0...defaultLevel {
            colors.append(SimonColor(rawValue: Int(arc4random_uniform(UInt32(4))))!)
        }
        delegate?.playButtons(0, position: 12, colors: colors)
    }
    
    // This function will be called every time the user presses a button
    // It should return true if the user wins the game or false if the user loses
    func evaluate(color : SimonColor) {
        let eval = colors[currentPress] == color
        
        if eval {
            
            if currentPress == (defaultLevel - 1) {
                delegate?.didWinTheGame()
            }
            
            if currentPress == currentLevel {
                currentLevel++
                startNewLevel()
            } else {
                currentPress++
            }
        } else {
            delegate?.didLostTheGame()
        }
    }
    
    func startNewLevel() {
        currentPress = 0
        delegate?.playButtons(0, position: currentLevel, colors: colors)
    }
}