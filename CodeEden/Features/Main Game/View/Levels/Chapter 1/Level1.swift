//
//  Level1.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 26/07/22.
//

import SwiftUI
import SceneKit

struct Level1: View{
    
    @State var codySpeech = false
    @State var openTutorial = false
    @State var starsCollected: Int = 0
    @State var levelCleared = false
    @State var rockCollision = false
    @State var openCodeEditor = false
    
    @State var initialPlayerPosition: SCNVector3 = SCNVector3(x: 0, y: -0.234, z: 0)
    
    @ObservedObject var playerInstruction: givenInstruction
    
    let choice: [instruction] = [instruction(id: 0, function: .step, direct: .forward), instruction(id: 1, function: .step, direct: .backward), instruction(id: 2, function: .step, direct: .left), instruction(id:3, function: .step, direct: .right)]
    
    let coinCategory = 2
    
    let rockCategory = 4
    
    let finishCategory = 16
    
    var scene = SCNScene(named: "Art.scnassets/Level1Scene.scn")!
    
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
                                    reset(player: playerNode!, coin: coinNode!, playerInitialPosition: initialPlayerPosition)
                                    
                                    starsCollected = 0
                                    playerInstruction.reset()
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: geo.size.height * 0.05).foregroundColor(Color( "whiteAccent"))
                                        
                                        Image(systemName:   "arrow.clockwise").font(.system(size: geo.size.width * 0.05)).foregroundColor(Color("mainPurple"))
                                    }
                                }
                                
                                Button {
                                    execute(instructions: playerInstruction.instructionList, player: playerNode!)
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: geo.size.height * 0.07 ).foregroundColor(Color( "mainPurple"))
                                        
                                        Image(systemName:  "play.square.fill").font(.system(size: geo.size.width * 0.1 )).foregroundColor(Color("whiteAccent" ))
                                    }
                                }
                                
                                Button {
                                    withAnimation {
                                        openCodeEditor.toggle()
                                    }
                                   
                    
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height:  geo.size.height * 0.05).foregroundColor(Color( "whiteAccent"))
                                        
                                        Image(systemName:  "chevron.left.forwardslash.chevron.right").font(.system(size: geo.size.width * 0.07)).foregroundColor(Color( "mainPurple"))
                                    }
                                }
                                
                             
                            }
                        }.frame(width: geo.size.width, height: geo.size.height * 0.06, alignment: .bottom).position(x: geo.size.width/2, y: geo.size.height * 0.96)
                        
                       if openCodeEditor
                        {
                           ZStack
                           {
                               RoundedRectangle(cornerRadius: 10).foregroundColor(Color("whiteAccent"))
                               
                               
                               VStack
                               {
                                   ZStack
                                   {
                                       RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame( height: geo.size.height * 0.1)
                                       Text("My Algo").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: 20))
                                   }
                                    
                                   
                                   ExtractedView(playerInstruction: playerInstruction)
                                   
                                   ScrollView(.horizontal, showsIndicators: false) {
                                       HStack
                                       {
                                           ForEach(0..<choice.count)
                                           {
                                               i in
                                               
                                               ZStack
                                               {
                                                   RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.3, height: geo.size.height * 0.05)
                                                   
                                                   if choice[i].function == .step
                                                   {
                                                       if self.choice[i].direct == .forward
                                                       {
                                                           Text("Step Forward").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
                                                       }
                                                       
                                                       else if self.choice[i].direct == .backward
                                                       {
                                                           Text("Step Backward").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
                                                       }
                                                       
                                                       else if self.choice[i].direct == .left
                                                       {
                                                           Text("Step Left").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
                                                       }
                                                       
                                                       else if self.choice[i].direct == .right
                                                       {
                                                           Text("Step Right").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
                                                       }
                                                   }
                                               }.gesture(TapGesture().onEnded({ _ in
                                                   playerInstruction.addToList(ins: choice[i])
                                               }))
                                              
                                           }
                                       }
                                   }
                                   
                                   
                               }
                           }.frame(width: geo.size.width * 0.9 , height: geo.size.height * 0.8).position(x: geo.size.width/2, y: geo.size.height/2)
                       }
                    }
                }.edgesIgnoringSafeArea(.all)
                    
            }
}

struct Level1_Previews: PreviewProvider {
    static var previews: some View {
        Level1(playerInstruction: givenInstruction())
    }
}

struct ExtractedView: View {
    
    @StateObject var playerInstruction = givenInstruction()
    
    var body: some View {
        
        List(playerInstruction.instructionList)
        {
            ins in
                
            if ins.function == .step
                {
                if ins.direct == .forward
                    {
                        Text("Step Forward")
                    }
                    
                    else if ins.direct == .backward
                    {
                        Text("Step Backward")
                    }
                    
                    else if ins.direct == .left
                    {
                        Text("Step Left")
                    }
                    
                    else
                    {
                        Text("Step Right")
                    }
                }
            
        }
    }
}
