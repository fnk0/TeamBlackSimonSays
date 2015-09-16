//
//  ViewController.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/3/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//

import UIKit
import AVFoundation

class GameController: UIViewController, SimonGameProtocol {
    
    // Holds the current game being played
    var game : SimonGame?
    
    // Labels
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var winLostLabel: UILabel!
    @IBOutlet weak var currentLevelLabel: UILabel!
    
    // Colored Buttons
    @IBOutlet weak var blueButton: TransparentButton!
    @IBOutlet weak var yellowButton: TransparentButton!
    @IBOutlet weak var redButton: TransparentButton!
    @IBOutlet weak var greenButton: TransparentButton!
    
    // Recognizer that will handle the start of the game
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    
    // Holds the buttons in the same order
    // As their color for convenience
    var buttons : [TransparentButton] = []
    
    // Sets the status bar to white instead of black.
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game = SimonGame(delegate: self)
        buttons.append(blueButton)
        buttons.append(redButton)
        buttons.append(greenButton)
        buttons.append(yellowButton)
        winLostLabel.text = ""
        updateHighScore()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Handles when a button is pressed
    // The color is extracted from the Tag defined
    // in the storyboard
    @IBAction func handleButtonPressed(sender: UIButton) {
        if self.game?.gameState == GameState.HumanPlaying {
            if let color = SimonColor(rawValue: sender.tag) {
                playBeep(color)
                game?.evaluate(color)
            }
        }
    }
    
    // Animates a single button during a sequence
    // When completed call the playSequence again in case there's
    func animateBtn(index: Int, position: Int, colors: [SimonColor]) {
        let button = buttons[colors[index].rawValue]
        playBeep(colors[index])
        print("Playing button with index: \(index) and color \(colors[index])")
        UIView.animateWithDuration(SimonGame.HighlightTime / 2,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                button.alpha = 0.90
                button.highlighted = true
                let color = button.currentTitleColor
                button.layer.shadowColor = color.CGColor
                button.layer.shadowRadius = 10.0
                button.layer.shadowOpacity = 0.9
                button.layer.shadowOffset = CGSizeZero
                button.layer.masksToBounds = false
            },
            completion: { finished in
                UIView.animateWithDuration(SimonGame.HighlightTime / 2,
                    delay: 0.0,
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: {
                        button.alpha = 1.0
                        button.highlighted = false
                        button.layer.shadowColor = UIColor.clearColor().CGColor
                        button.layer.shadowRadius = 0.0
                        button.layer.shadowOpacity = 0.0
                        button.layer.masksToBounds = true
                        
                    },
                    completion: { finished in
                        if self.game?.gameState == GameState.SequencePlaying {
                            let newIndex = index + 1
                            self.playButtons(newIndex, position: position, colors: colors)
                        }
                })
        })
    }
    
    // All the 4 buttons call this function to handle a button press
    // We get which color by pressed by the button tag defined in
    // The storyboard file.
    // The storyboard tag matches the enum numbers of the SimonColor enum
    @IBAction func handleScreenTap(sender: AnyObject) {
        if self.game?.gameState == GameState.NotPlaying {
            self.winLostLabel.text = ""
            self.startLabel.text = ""
            game?.startGame()
        }
        return
    }
    
    // Plays the sequence of buttons
    func playButtons(start: Int, position: Int, colors: [SimonColor]) {
        currentLevelLabel.text = "\(position)"
        self.game?.gameState = GameState.SequencePlaying
        if start == position {
            self.game?.gameState = GameState.HumanPlaying
            return
        }
        animateBtn(start, position: position, colors: colors)
    }
    
    // Function tha will be called from SimoNGame whenever the game has been won
    func didWinTheGame() {
        self.winLostLabel.text = "You win!!"
        enableStart()
    }
    
    // Function that gets called when the game is lost
    func didLostTheGame() {
        self.winLostLabel.text = "You lose :("
        enableStart()
    }
    
    // Convenience method to reduce redundancy on the win and lost game
    func enableStart() {
        updateHighScore()
        self.game?.gameState = GameState.NotPlaying
        self.startLabel.text = "TAP THE SCREEN TO START"
    }
    
    // Plays a beep song based on a color
    func playBeep(color: SimonColor) {
        game?.beeps[color.rawValue].play()
    }
    
    // Updates the HighScore
    // The HighScore gets saved in NSUserDefaults for
    // future app launches
    func updateHighScore() {
        if var level = game?.currentLevel {
            level = level - 1
            if let score = game?.defaults.valueForKey(SimonGame.highScoreString) as! Int? {
                if level < score {
                    level = score
                }
            }
            game!.defaults.setValue(level, forKey: SimonGame.highScoreString)
            highScoreLabel.text = "\(level)"
            print ("\(level)")
        }
    }
}

