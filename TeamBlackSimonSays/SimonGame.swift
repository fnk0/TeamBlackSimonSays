//
//  SimonGameGenerator.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/3/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//

import Foundation

// This file purpose is to hold a single Simon Game
// Every time the user starts a new game a new instance of this class should be created.
// The idea is to replace the current instance with a new one.
class SimonGame {
    
    // The default number of colors the user needs to 
    // get right to win the game
    let defaultLevel = 12
    
    // Holds which level is the player playing
    var currentLevel = 0
    
    // Holds the colors that will represent this game
    var colors = [SimonColor]()
    
    // This function will be called every time the user presses a button
    // It should return true if the user wins the game or false if the user loses
    func evaluate(color : SimonColor) -> Bool{
        return colors[currentLevel] == color
    }
}