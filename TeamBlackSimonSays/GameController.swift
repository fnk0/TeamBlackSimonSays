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
    
    var game : SimonGame?
    var gameState = GameState.NotPlaying
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var winLostLabel: UILabel!
    @IBOutlet weak var currentLevelLabel: UILabel!
    
    @IBOutlet weak var blueButton: TransparentButton!
    @IBOutlet weak var yellowButton: TransparentButton!
    @IBOutlet weak var redButton: TransparentButton!
    @IBOutlet weak var greenButton: TransparentButton!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    
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
    
    @IBAction func handleButtonPressed(sender: UIButton) {
        if gameState == GameState.HumanPlaying {
            if let color = SimonColor(rawValue: sender.tag) {
                playBeep(color)
                game?.evaluate(color)
            }
        }
    }
    
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
                        if self.gameState == GameState.SequencePlaying {
                            let newIndex = index + 1
                            self.playButtons(newIndex, position: position, colors: colors)
                        }
                })
        })
    }
    
    @IBAction func handleScreenTap(sender: AnyObject) {
        if gameState == GameState.NotPlaying {
            self.winLostLabel.text = ""
            self.startLabel.text = ""
            game?.startGame()
        }
        return
    }
    
    func enableButtons() {
        for b in buttons {
            b.enabled = true
        }
    }
    
    func disableButtons() {
        for b in buttons {
            b.enabled = false
        }
    }
    
    func playButtons(start: Int, position: Int, colors: [SimonColor]) {
        currentLevelLabel.text = "\(position)"
        gameState = GameState.SequencePlaying
        if start == position {
            gameState = GameState.HumanPlaying
            return
        }
        animateBtn(start, position: position, colors: colors)
    }
    
    func didWinTheGame() {
        updateHighScore()
        gameState = GameState.NotPlaying
        self.winLostLabel.text = "You win!!"
        self.startLabel.text = "TAP THE SCREEN TO START"
    }
    
    func didLostTheGame() {
        updateHighScore()
        gameState = GameState.NotPlaying
        self.winLostLabel.text = "You lose :("
        self.startLabel.text = "TAP THE SCREEN TO START"
    }
    
    func playBeep(color: SimonColor) {
        game?.beeps[color.rawValue].play()
    }
    
    func updateHighScore() {
        if var level = Int(currentLevelLabel.text!) {
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

