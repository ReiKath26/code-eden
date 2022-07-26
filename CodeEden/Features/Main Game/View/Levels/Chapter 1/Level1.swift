//
//  Level1.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 26/07/22.
//

import SwiftUI
import SceneKit

struct Level1: View {
    
    @State var codySpeech = false
    @State var openTutorial = false
    @State var starsCollected: Int = 0
    @State var levelCleared = false
    @State var rockCollision = false
    
    @State var initialPlayerPosition: SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    
    var scene = SCNScene(named: "Art.scnassets/Level1Scene.scn")!
    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
            }
    var playerNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "pasted_pSphere8", recursively: true)
    }
    
    var coinNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "pCylinder1", recursively: true)
    }
    
    var rocksNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "pPlatonic1", recursively: true)
    }
    
    var goalNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "plane", recursively: true)
    }
            
            var body: some View {
                
                ZStack
                {
                    SceneView(
                            scene: scene,
                            pointOfView: cameraNode,
                            options: [.allowsCameraControl]
                    )
                    
                    GeometryReader
                    {
                        geo in
                        
                        ZStack
                        {
                            Rectangle().foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width, height: geo.size.height * 0.07)
                            
                            HStack(spacing: 30)
                            {
                                Button {
                                    print("Woohoo")
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: geo.size.height * 0.05).foregroundColor(Color( "whiteAccent"))
                                        
                                        Image(systemName:   "arrow.clockwise").font(.system(size: geo.size.width * 0.05)).foregroundColor(Color("mainPurple"))
                                    }
                                }
                                
                                Button {
                                    print("Woohoo")
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: geo.size.height * 0.07 ).foregroundColor(Color( "mainPurple"))
                                        
                                        Image(systemName:  "play.square.fill").font(.system(size: geo.size.width * 0.1 )).foregroundColor(Color("whiteAccent" ))
                                    }
                                }
                                
                                Button {
                                    
                                    print("Woohoo")
                    
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height:  geo.size.height * 0.05).foregroundColor(Color( "whiteAccent"))
                                        
                                        Image(systemName:  "chevron.left.forwardslash.chevron.right").font(.system(size: geo.size.width * 0.07)).foregroundColor(Color( "mainPurple"))
                                    }
                                }
                                
                             
                            }
                        }.frame(width: geo.size.width, height: geo.size.height * 0.06, alignment: .bottom).position(x: geo.size.width/2, y: geo.size.height * 0.96)
                    }
                }.edgesIgnoringSafeArea(.all)
                    
            }
}

struct Level1_Previews: PreviewProvider {
    static var previews: some View {
        Level1()
    }
}
