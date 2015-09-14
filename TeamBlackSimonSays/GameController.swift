//
//  ViewController.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/3/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game = SimonGame(delegate: self)
        buttons.append(blueButton)
        buttons.append(redButton)
        buttons.append(greenButton)
        buttons.append(yellowButton)
        winLostLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleButtonPressed(sender: UIButton) {
        if gameState == GameState.HumanPlaying {
            if let color = SimonColor(rawValue: sender.tag) {
                game?.evaluate(color)
            }
        }
    }
    
    func animateBtn(index: Int, position: Int, colors: [SimonColor]) {
        let button = buttons[colors[index].rawValue]
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
                        let newIndex = index + 1
                        self.playButtons(newIndex, position: position, colors: colors)
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
        print("Win the game!")
        gameState = GameState.NotPlaying
        self.winLostLabel.text = "You win!!"
        self.startLabel.text = "TAP THE SCREEN TO START"
    }
    
    func didLostTheGame() {
        print("Lost the game!")
        gameState = GameState.NotPlaying
        self.winLostLabel.text = "You lose :("
        self.startLabel.text = "TAP THE SCREEN TO START"
    }
    
    func updateHighScore() {
        
        var scoreToSave = Int(currentLevelLabel.text!)
        
        if let score = game?.defaults.valueForKey(SimonGame.highScoreString) as! String? {
            
            if scoreToSave < Int(score) {
                scoreToSave = Int(score)
            }
            
        }
        
        game!.defaults.setValue(scoreToSave, forKey: SimonGame.highScoreString)

    }
}

