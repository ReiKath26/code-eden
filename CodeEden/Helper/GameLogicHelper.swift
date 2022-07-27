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
    switch direct
    {
        case .forward:
            player.position.z -= 4
        case .backward:
            if player.position.z != 0
            {
                player.position.z += 4
            }
        case .left:
            player.position.x += 4
        case .right:
            player.position.x -= 4
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
