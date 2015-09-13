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
        currentScoreLabel.text = ""
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
        print("Playing button with index: \(index)")
        let button = buttons[colors[index].rawValue]
        button.highlighted = true
        let color = button.currentTitleColor
        button.layer.shadowColor = color.CGColor
        button.layer.shadowRadius = 10.0
        button.layer.shadowOpacity = 0.9
        button.layer.shadowOffset = CGSizeZero
        button.layer.masksToBounds = false
        
        NSThread.sleepForTimeInterval(0.5)
        
        dispatch_after(500, dispatch_get_main_queue(), {
            button.layer.shadowColor = UIColor.clearColor().CGColor
            button.layer.shadowRadius = 0.0
            button.layer.shadowOpacity = 0.0
            button.layer.masksToBounds = true
            button.highlighted = false
            let newIndex = index + 1
            self.playButtons(newIndex, position: position, colors: colors)
        })
        
//        if let originalImage = button.backgroundImageForState(UIControlState.Normal) {
//            if let image = button.backgroundImageForState(UIControlState.Highlighted) {
//                button.setImage(image, forState: UIControlState.Normal)
//           
//            }
//            

//                if let bgImage = button.backgroundImageForState(UIControlState.Normal) {
//                    button.setImage(bgImage, forState: UIControlState.Highlighted)
//                    button.setImage(originalImage, forState: UIControlState.Normal)
//               
//                }
//            })
//        }
    }
    
    @IBAction func handleScreenTap(sender: AnyObject) {
        if gameState == GameState.NotPlaying {
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
        if start == position {
            return
        }
        animateBtn(start, position: position, colors: colors)
    }
    
    func didWinTheGame() {
        
    }
    
    func didLostTheGame() {
        
    }
}

