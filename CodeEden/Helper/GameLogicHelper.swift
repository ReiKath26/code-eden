//
//  GameLogicHelper.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 27/07/22.
//

import Foundation
import SceneKit
import SwiftUI

enum algo
{
    case step
    case jump
}

enum levelStat
{
    case cleared
    case crash
    case goalNotReached
}

class givenInstruction: ObservableObject
{
    @Published var instructionList: [instruction] = []
    
    func addToList(ins: instruction)
    {
        instructionList.append(ins)
    }
    
    func reset()
    {
        instructionList.removeAll()
    }
}


struct instruction: Identifiable
{
    var id: Int
    var function: algo
    var direct: direction
}

enum direction
{
    case forward
    case backward
    case left
    case right
}

func setLevelStatus(instructions: [instruction], levelID: Int) -> (levelStat, Int, Int)
{
    var levelStatus : levelStat = .goalNotReached
    var starCount = 0
    var lineCount = 0
    
    switch levelID
    {
        case 1:
        
        let correct = [instruction(id: 0, function: .step, direct: .forward), instruction(id: 0, function: .step, direct: .forward), instruction(id: 0, function: .step, direct: .forward), instruction(id: 0, function: .step, direct: .forward)]
        
        let crash1 = [instruction(id: 2, function: .step, direct: .left)]
        
        let crash2 = [instruction(id: 0, function: .step, direct: .forward), instruction(id: 0, function: .step, direct: .forward), instruction(id: 3, function: .step, direct: .right)]
        
        let crash3 = [instruction(id: 0, function: .step, direct: .forward), instruction(id: 0, function: .step, direct: .forward), instruction(id: 0, function: .step, direct: .forward), instruction(id: 0, function: .step, direct: .left)]
        
        var check: (Bool, Bool, Bool, Bool) = (checkInstructions(instructions: instructions, sample: correct), checkInstructions(instructions: instructions, sample: crash1), checkInstructions(instructions: instructions, sample: crash2), checkInstructions(instructions: instructions, sample: crash3))
        
        if check.0
        {
            levelStatus = .cleared
            starCount = 3
            lineCount = instructions.count
            
        }
        
        else if check.1 || check.2 || check.3
        {
            levelStatus = .crash
        }
        
        else
        {
            levelStatus = .goalNotReached
        }
            
    default:
        levelStatus = .goalNotReached
        starCount = 0
    }
    
    return (levelStatus, starCount, lineCount)
}

func checkInstructions(instructions: [instruction], sample: [instruction]) -> Bool
{
    for x in 0..<sample.count
    {
        if instructions[x].id != sample[x].id
        {
            return false
        }
    }
    
    return true
}

func execute(instructions: [instruction], player: SCNNode)
{
    
        for instruction in instructions {
           
            switch instruction.function
            {
                case .step:
                step(direct: instruction.direct, player: player)
                case .jump:
                jump(direct: instruction.direct, player: player)
            }

        }
    
}


func reset(player: SCNNode, coin: SCNNode, playerInitialPosition: SCNVector3)
{
    player.position = playerInitialPosition
    coin.isHidden = false
}

func step(direct: direction, player: SCNNode)
{
    let moveForward = SCNAction.moveBy(x: 0, y: 0, z: -4, duration: 1)
    
    let moveBackward = SCNAction.moveBy(x: 0, y: 0, z: 4, duration: 1)
    
    let moveLeft = SCNAction.moveBy(x: -4, y: 0, z: 0, duration: 1)
    
    let moveRight = SCNAction.moveBy(x: 4, y: 0, z: 0, duration: 1)
    switch direct
    {
        case .forward:
            player.runAction( moveForward )
        case .backward:
            if player.position.z != 0
            {
                player.runAction(moveBackward)
            }
        case .left:
            player.runAction(moveLeft)
        case .right:
            player.runAction(moveRight)
    }
    
}

func jump(direct: direction, player: SCNNode)
{
    switch direct
    {
        case .forward:
            player.physicsBody?.applyForce(SCNVector3(x: 0, y: 4, z: -2), asImpulse: true)
        case .backward:
        if player.position.z != 0
        {
            player.physicsBody?.applyForce(SCNVector3(x: 0, y: 4, z: +2), asImpulse: true)
        }
        case .left:
            player.physicsBody?.applyForce(SCNVector3(x: +2, y: 4, z: 0), asImpulse: true)
        case .right:
            player.physicsBody?.applyForce(SCNVector3(x: -2, y: 4, z: 0), asImpulse: true)
    }
}
