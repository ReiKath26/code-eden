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
    case binSearch
    case pathFinding
}

enum levelStat
{
    case cleared
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
    
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eight
}

func setLevelStatus(instructions: [instruction], levelID: Int) -> (levelStat, Int, Int)
{
    var levelStatus : levelStat = .goalNotReached
    var starCount = 0
    var lineCount = 0
    
    switch levelID
    {
        case 1:
        
        let correct = [0, 0, 0, 0]
        
        let check: Bool = checkInstructions(instructions: instructions, sample: correct)
        
        if check
        {
            levelStatus = .cleared
            starCount = 3
            lineCount = instructions.count
            
        }
        
        else
        {
            levelStatus = .goalNotReached
        }
        
        case 2:
        
        let correct1 = [0, 7, 0, 4, 3]
        let correct2 = [0, 7, 0, 3, 0, 0]
        
        let check: (Bool, Bool) = (checkInstructions(instructions: instructions, sample: correct1), checkInstructions(instructions: instructions, sample: correct2))
        
        if check.0 || check.1
        {
            levelStatus = .cleared
            
            if check.0
            {
                starCount = 3
            }
            
            else
            {
                starCount = 2
            }
            
            lineCount = instructions.count
        }
        
        else
        {
            levelStatus = .goalNotReached
        }
        
        case 3:
        
        let correct = [8,9,10,11,12,13,14,15]
        
        let check = checkInstructions(instructions: instructions, sample: correct)
        
        if check
        {
            levelStatus = .cleared
            
            starCount = 3
            
            lineCount = instructions.count
        }
        
        else
        {
            levelStatus = .goalNotReached
        }
        
        case 4:
        
        let correct = [16, 17, 18, 19]
        let correct2 = [16, 18, 19, 17]
        
        let check : (Bool, Bool) = (checkInstructions(instructions: instructions, sample: correct), checkInstructions(instructions: instructions, sample: correct2))
        
        if check.0 || check.1
        {
            levelStatus = .cleared
            
            starCount = 3
            
            lineCount = instructions.count
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

func checkInstructions(instructions: [instruction], sample: [Int]) -> Bool
{
    for x in 0..<sample.count
    {
        if instructions[x].id != sample[x]
        {
            return false
        }
    }
    
    return true
}

func execute(instructions: [instruction], player: SCNNode)
{
    
        for x in 0..<instructions.count {
           
            switch instructions[x].function
            {
                case .step:
                step(direct: instructions[x].direct, player: player)
                case .jump:
                jump(direct: instructions[x].direct, player: player)
                case .binSearch:
                simulateBinarySearch(player: player)
                case .pathFinding:
                simulatePathFinding(player: player)
            }

        }
    
}

func simulatePathFinding(player: SCNNode)
{
    
}

func simulateBinarySearch(player: SCNNode)
{
    let number = Int.random(in: 1...7)
    
    switch number
    {
        case 1:
        player.runAction(SCNAction.move(by: SCNVector3(x: 1.5, y: 0, z: 0), duration: 1), completionHandler: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2)
            {
                player.runAction(SCNAction.move(by: SCNVector3(x: 0.8, y: 0, z: 0), duration: 1))
            }
          
        })
        case 2:
        player.runAction(SCNAction.move(by: SCNVector3(1.5, 0, 0), duration: 1))
        case 3:
        player.runAction(SCNAction.move(by: SCNVector3(x: 1.5, y: 0, z: 0), duration: 1), completionHandler: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2)
            {
                player.runAction(SCNAction.move(by: SCNVector3(x: -0.8, y: 0, z: 0), duration: 1))
            }
          
        })
        
        case 4:
        player.position = player.position
        case 5:
        player.runAction(SCNAction.move(by: SCNVector3(x: -1.5, y: 0, z: 0), duration: 1), completionHandler: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2)
            {
                player.runAction(SCNAction.move(by: SCNVector3(x: 0.8, y: 0, z: 0), duration: 1))
            }
          
        })
        case 6:
        player.runAction(SCNAction.move(by: SCNVector3(-1.5, 0, 0), duration: 1))
        case 7:
        player.runAction(SCNAction.move(by: SCNVector3(x: -1.5, y: 0, z: 0), duration: 1), completionHandler: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2)
            {
                player.runAction(SCNAction.move(by: SCNVector3(x: -0.8, y: 0, z: 0), duration: 1))
            }
          
        })
        default:
        print("Do nothing")
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
    case .first:
        print("do nothing")
    case .second:
        print("do nothing")
    case .third:
        print("do nothing")
    case .fourth:
        print("do nothing")
    case .fifth:
        print("do nothing")
    case .sixth:
        print("do nothing")
    case .seventh:
        print("do nothing")
    case .eight:
        print("do nothing")
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
    case .first:
        print("do nothing")
    case .second:
        print("do nothing")
    case .third:
        print("do nothing")
    case .fourth:
        print("do nothing")
    case .fifth:
        print("do nothing")
    case .sixth:
        print("do nothing")
    case .seventh:
        print("do nothing")
    case .eight:
        print("do nothing")
    }
}
