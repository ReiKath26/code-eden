//
//  Level1.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 26/07/22.
//

import SwiftUI
import SceneKit

struct Level1: View {
    
    var scene = SCNScene(named: "Art.scnassets/LevelScene.scn")!
    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
            }
            
            var body: some View {
                
                ZStack
                {
                    SceneView(
                            scene: scene,
                            pointOfView: cameraNode,
                            options: [.allowsCameraControl]
                    )
                }
                    
            }
}

struct Level1_Previews: PreviewProvider {
    static var previews: some View {
        Level1()
    }
}
