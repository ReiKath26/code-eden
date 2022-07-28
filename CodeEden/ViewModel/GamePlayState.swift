//
//  GamePlayState.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 26/07/22.
//

import Foundation

enum gameState
{
    case main
    case play
}

class GamePlayState: ObservableObject
{
    @Published var currentState: gameState = .main
    
}

class levelToBePlayed: ObservableObject
{
    @Published var levelID = 0
    @Published var playTime = false
}
