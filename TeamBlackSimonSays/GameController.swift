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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game = SimonGame(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func handleGreen(sender: UIButton) {
        game?.evaluate(SimonColor.Green)
    }
    
    @IBAction func handleRed(sender: UIButton) {
        game?.evaluate(SimonColor.Red)
    }
    
    @IBAction func handleBlue(sender: UIButton) {
        game?.evaluate(SimonColor.Blue)
    }
    
    @IBAction func handleYellow(sender: AnyObject) {
        game?.evaluate(SimonColor.Yellow)
    }
    
    func handleEvaluateResult(result : Bool) {
        
        if result && game?.currentPress == game?.currentLevel {
            // win the game
        } else {
            // loose the game
        }
    }
    
    func playButtons(position: Int, colors: [SimonColor]) {
        
    }
    
    func didWinTheGame() {
        
    }
    
    func didLostTheGame() {
        
    }
}

