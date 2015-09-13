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
    
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var winLostLabel: UILabel!
    @IBOutlet weak var currentLevelLabel: UILabel!
    
    @IBOutlet weak var blueButton: TransparentButton!
    @IBOutlet weak var yellowButton: TransparentButton!
    @IBOutlet weak var redButton: TransparentButton!
    @IBOutlet weak var greenButton: TransparentButton!
    
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
        currentScoreLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleButtonPressed(sender: UIButton) {
        
        let color = sender.currentTitleColor
        sender.layer.shadowColor = color.CGColor
        sender.layer.shadowRadius = 10.0
        sender.layer.shadowOpacity = 0.9
        sender.layer.shadowOffset = CGSizeZero
        sender.layer.masksToBounds = false
        
        if let color = SimonColor(rawValue: sender.tag) {
            game?.evaluate(color)
        }
    }
    
    func enableButtons() {
        for b in buttons {
            b.enabled = true
        }
    }
    
    func diableButtons() {
        for b in buttons {
            b.enabled = false
        }
    }
    
    func playButtons(position: Int, colors: [SimonColor]) {
        
    }
    
    func didWinTheGame() {
        
    }
    
    func didLostTheGame() {
        
    }
}

