
//
//  SimonGameGenerator.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/3/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//s

import Foundation
import AVFoundation

protocol SimonGameProtocol {
    func didWinTheGame()
    func didLostTheGame()
    func playButtons(start : Int, position : Int, colors : [SimonColor])
    func animateBtn(start : Int, position: Int, colors: [SimonColor])
}

// This file purpose is to hold a single Simon Game
// Every time the user starts a new game a new instance of this class should be created.
// The idea is to replace the current instance with a new one.
class SimonGame {
    
    // blue = G3
    // red = e4
    // green = g5
    // yellow = c5
    var beeps = [AVAudioPlayer]()
    let beepNames = ["g3", "e4", "g5", "c5"]
    
    static let HighlightTime = 1.0
    
    let defaults = NSUserDefaults.standardUserDefaults()
    static let highScoreString : String = "High Score"
    
    var delegate : SimonGameProtocol?
    
    // The default number of colors the user needs to
    // get right to win the game
    let defaultLevel = 12
    
    // Holds which level is the player playing
    var currentLevel = 1
    
    var currentPress = 0
    
    // Holds the colors that will represent this game
    var colors = [SimonColor]()
    
    required init(delegate : SimonGameProtocol) {
        self.delegate = delegate
        beeps = [AVAudioPlayer]()
        for b in beepNames {
            beeps.append(setupAudioPlayerWithFile(b)!)
        }
    }
    
    func startGame() {
        colors = [SimonColor]()
        print("Starting game...")
        for _ in 0...defaultLevel {
            colors.append(SimonColor(rawValue: Int(arc4random_uniform(UInt32(4))))!)
        }
        currentLevel = 1
        startNewLevel()
    }
    
    // This function will be called every time the user presses a button
    // It should return true if the user wins the game or false if the user loses
    func evaluate(color : SimonColor) {
        let eval = colors[currentPress] == color
        if eval {
            if currentPress == (defaultLevel - 1) {
                delegate?.didWinTheGame()
                return
            }
            
            if currentPress == (currentLevel - 1) {
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
        print("Starting new level...")
        currentPress = 0
        delegate?.playButtons(0, position: currentLevel, colors: colors)
    }
    
    func setupAudioPlayerWithFile(fileName: NSString) -> AVAudioPlayer?  {
        let path = NSBundle.mainBundle().pathForResource(fileName as String, ofType: "mp3")
        let url = NSURL.fileURLWithPath(path!)
        do {
            return try AVAudioPlayer(contentsOfURL: url)
        } catch {
            return nil
        }
    }
}