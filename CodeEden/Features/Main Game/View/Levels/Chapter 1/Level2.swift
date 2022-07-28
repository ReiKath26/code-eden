//
//  Level2.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 26/07/22.
//

import SwiftUI
import SceneKit

struct Level2: View {
    
    
    @State var openTutorial = true
    @State var starsCollected = 0
    @State var lineCount = 0
    @State var index = 0
    @State var levelCleared = false
    @State var nextLevel = false
    @State var goalNotReached = false
    @State var showAlert = false
    @State var openCodeEditor = false
    
    @AppStorage("stars") var playerStars: Int = 0
    @AppStorage("playerHint") var hintCount: Int = 0
    @AppStorage("chapters") var savedChapter: [chapter] = populateChapter()
    @AppStorage("levels") var savedLevel: [level] = populateLevel()
    @AppStorage("achievements") var achievementData: [achievement] = populateAchievement()
    @AppStorage("glossaries") var savedGlossaries: [glossary] = populateGlossaries()
    
    @ObservedObject var setUp: GamePlayState
    
    @State var initialPlayerPosition: SCNVector3 = SCNVector3(x: 0, y: -0.234, z: 0)
    
    @ObservedObject var playerInstruction: givenInstruction
    
    let tut: [tutorial] = [tutorial(illustration: "Level2_1", instruction: "If Codes crashes into a rock, they will be hurt. You need to either swerve around them or use the Jump algorithm to jump over them."), tutorial(illustration: "Level2_2", instruction: "There will be star coins available in each level. Be sure to collect them!"), tutorial(illustration: "Level2_3", instruction: "On certain level with different color tile like this, it means your main goal is to reach them."), tutorial(illustration: "loupe", instruction: "You can click on the hint button to get hint on the solution of the level. Good luck!")]
    
    let choice: [instruction] = [instruction(id: 0, function: .step, direct: .forward), instruction(id: 1, function: .step, direct: .backward), instruction(id: 2, function: .step, direct: .left), instruction(id:3, function: .step, direct: .right), instruction(id: 4, function: .jump, direct: .forward), instruction(id: 5, function: .jump, direct: .backward),instruction(id: 6, function: .jump, direct: .left),instruction(id: 7, function: .jump, direct: .right)]
    
    
    var scene = SCNScene(named: "Art.scnassets/Level2Scene.scn")!
    
    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
            }
    
    var playerNode: SCNNode?
    {
        var node: SCNNode
        node = scene.rootNode.childNode(withName: "eva", recursively: true)!
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
                            playerInstruction.reset()
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: geo.size.height * 0.05).foregroundColor(Color( "whiteAccent"))
                                
                                Image(systemName:   "arrow.clockwise").font(.system(size: geo.size.width * 0.05)).foregroundColor(Color("mainPurple"))
                            }
                        }.disabled(openTutorial || showAlert || levelCleared ? true : false)
                        
                        Button {
                            
                            if playerInstruction.instructionList.count == 0
                            {
                                withAnimation {
                                    goalNotReached.toggle()
                                    showAlert.toggle()
                                }
                            }
                            
                            else
                            {
                                let status = setLevelStatus(instructions: playerInstruction.instructionList, levelID: 2)
                                
                                
                                if status.0 == .cleared
                                {
//                                    execute(instructions: playerInstruction.instructionList, player: playerNode!)
                                    
                                    
                                    withAnimation(Animation.linear(duration: 2)) {
                                        
                                        coinNode?.isHidden = true
                                    }
                                    
                                    withAnimation{
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3)
                                        {
                                            lineCount += status.2
                                            starsCollected += status.1
                                            playerStars += status.1
                                            hintCount += 3
                                            savedLevel[0].starsCount += status.1
                                            savedLevel[0].cleared = true
                                            savedChapter[0].levelDone += 1
                                            achievementData[0].count += status.1
                                            achievementData[1].count += 1
                                            savedGlossaries[0].isUnlocked = true
                                            levelCleared.toggle()
                                            
                                           
                                        }
                                    }
                                }
                                
                                
                                else
                                {
                                    withAnimation {
                                        goalNotReached.toggle()
                                        showAlert.toggle()
                                    }
                                }
                            }
                            
                
                            
                            
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: geo.size.height * 0.07 ).foregroundColor(Color( "mainPurple"))
                                
                                Image(systemName:  "play.square.fill").font(.system(size: geo.size.width * 0.1 )).foregroundColor(Color("whiteAccent" ))
                            }
                        }.disabled(openTutorial || showAlert || levelCleared ? true : false)
                        
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
                        }.disabled(openTutorial || showAlert || levelCleared ? true : false)
                        
                     
                    }
                }.frame(width: geo.size.width, height: geo.size.height * 0.06, alignment: .bottom).position(x: geo.size.width/2, y: geo.size.height * 0.96)
                
                if openTutorial
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.7)
                        
                        VStack(spacing: 30)
                        {
                            Image(tut[index].illustration).resizable().frame(width: geo.size.width * 0.5, height: geo.size.height * 0.3)
                            
                            Text(tut[index].instruction).foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.03)).multilineTextAlignment(.center).frame(width: geo.size.width * 0.6)
                            
                            if index < (tut.count - 1)
                            {
                                Button {
                                    withAnimation {
                                        index += 1
                                    }
                                    
                                } label: {
                                    Text("Next").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.05))
                                }

                            }
                            
                            else
                            {
                                Button
                                {
                                    withAnimation {
                                        openTutorial.toggle()
                                    }
                                    
                                } label:
                                {
                                    Text("Okay").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.05))
                                }
                            }
                        }
                    }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.7).position(x: geo.size.width/2, y: geo.size.height/2)
                }
                
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
                                           
                                           else if choice[i].function == .jump
                                           {
                                               if self.choice[i].direct == .forward
                                               {
                                                   Text("Jump Forward").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
                                               }
                                               
                                               else if self.choice[i].direct == .backward
                                               {
                                                   Text("Jump Backward").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
                                               }
                                               
                                               else if self.choice[i].direct == .left
                                               {
                                                   Text("Jump Left").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
                                               }
                                               
                                               else if self.choice[i].direct == .right
                                               {
                                                   Text("Jump Right").font(Font.custom("Silom", size: geo.size.width * 0.03)).foregroundColor(Color("whiteAccent"))
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
                
                if levelCleared
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.5)
                        
                        VStack
                        {
                            Text("Level cleared in \(lineCount) lines!").font(Font.custom("Silom", size: geo.size.width * 0.07)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.7)
                            
                            HStack
                            {
                                Image("star").resizable().frame(width: geo.size.width * 0.15, height: geo.size.width * 0.15).opacity(starsCollected >= 1 ? 1:0.3)
                                Image("star").resizable().frame(width: geo.size.width * 0.15, height: geo.size.width * 0.15).opacity(starsCollected >= 2 ? 1:0.3)
                                Image("star").resizable().frame(width: geo.size.width * 0.15, height: geo.size.width * 0.15).opacity(starsCollected >= 3 ? 1:0.3)
                            }
                            
                            Text("\(starsCollected)/ 3 stars collected!").font(Font.custom("Silom", size: geo.size.width * 0.07)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.7)
                            
                            HStack
                            {
                            
                                    Button {
                                        withAnimation
                                        {
                                            setUp.currentState = .main
                                        }
                                       
                                    } label: {
                                        
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.4, height: geo.size.height * 0.07)
                                            
                                            Text("Back to Level Selection").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width * 0.3)
                                        }
                                        
                                    }
                                
                                Button {
                                    withAnimation {
                                        nextLevel.toggle()
                                    }
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.3, height: geo.size.height * 0.07)
                                        
                                        Text("Next Level").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("whiteAccent"))
                                    }
                                   
                                }


                                
                            }
                        }
                        
                    }.position(x: geo.size.width/2, y: geo.size.height/2)
                }
                
                if showAlert
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.3)
                        
                        VStack
                        {
                            Image("Cody - Sad").resizable().frame(width: geo.size.width * 0.5, height: geo.size.height * 0.25)
                            
                            Text(goalNotReached ? "Cody thinks the goal will not be reached this way. Let's try again!" : "Oh no, you will crash this way! Let's try again!").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("mainPurple")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.7)
                            
                            HStack
                            {
                                
                                    Button {
                                        reset(player: playerNode!, coin: coinNode!, playerInitialPosition: initialPlayerPosition)
                                        playerInstruction.reset()
                                        
                                        withAnimation {
                                            showAlert.toggle()
                                        }
                                    } label: {
                                        
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.3, height: geo.size.height * 0.07)
                                            
                                            Text("Try again").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("whiteAccent"))
                                        }
                                       
                                    }

                                    Button {
                                        setUp.currentState = .main
                                    } label: {
                                        
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.4, height: geo.size.height * 0.07)
                                            
                                            Text("Back to Level Selection").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width * 0.3)
                                        }
                                        
                                    }


                                
                            }
                        }
                    }.position(x: geo.size.width/2, y: geo.size.height/2)
                    
                    
                }
                
                if nextLevel
                {
                    Level2(setUp: setUp, playerInstruction: playerInstruction)
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Level2_Previews: PreviewProvider {
    static var previews: some View {
        Level2(setUp: GamePlayState(), playerInstruction: givenInstruction())
    }
}
