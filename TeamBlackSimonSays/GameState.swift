//
//  GameState.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/7/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//

import Foundation

// Holds the current game state
enum GameState {
    case NotPlaying // When there's no game being playing
    case HumanPlaying // When it's the human turn
    case SequencePlaying // Whenever the light sequence is playing
    
}