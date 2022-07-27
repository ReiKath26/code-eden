//
//  gameScene.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 27/07/22.
//

import SwiftUI
import SceneKit

struct gameScene: UIViewRepresentable
{
    let coinCategory = 2
    
    let rockCategory = 4
    
    let finishCategory = 16
    
    var scene : SCNScene
    
    var scnview = SCNView()
    
    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
            }
    var playerNode: SCNNode?
    {
        var node: SCNNode
        node = scene.rootNode.childNode(withName: "adira", recursively: true)!
        node.physicsBody?.contactTestBitMask = coinCategory | rockCategory | finishCategory
        
        return node
    }
    
    var coinNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "coin", recursively: true)
    }
    
    var rocksNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "pPlatonic1", recursively: true)
    }
    
    var goalNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "plane", recursively: true)
    }
    typealias UIViewType = SCNView
    
    func makeUIView(context: Context) -> SCNView {
        scnview.scene = scene
        
        return scnview
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let firstNode = contact.nodeA
        let secondNode = contact.nodeB
        
        print(firstNode.name! + " hit to " + secondNode.name!)
    }
    
//    func execute(instructions: [instruction])
//    {
//        
//            for instruction in instructions {
//               
//                switch instruction.function
//                {
//                    case .step:
//                    step(direct: instruction.direct, player: playerNode!)
//                    case .jump:
//                    jump(direct: instruction.direct, player: playerNode!)
//                }
//            }
//
//        
//    }
    
   
}

