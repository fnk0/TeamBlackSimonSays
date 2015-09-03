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
    
    // Holds which button press this is
    var currentBtnPress = 0
    
    // Holds the colors that will represent this game
    var colors = [SimonColor]()
}