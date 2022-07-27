//
//  GameLogicHelper.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 27/07/22.
//

import Foundation
import GameplayKit
import SceneKit

enum algo
{
    case step
    case jump
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
