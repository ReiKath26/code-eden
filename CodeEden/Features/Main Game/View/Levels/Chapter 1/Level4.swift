//
//  Level4.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 26/07/22.
//

import SwiftUI
import SceneKit

struct Level4: View {
    
    
    @State var openTutorial = true
    @State var starsCollected = 0
    @State var lineCount = 0
    @State var index = 0
    @State var levelCleared = false
    @State var goalNotReached = false
    @State var showAlert = false
    @State var openCodeEditor = false
    @State var useHint = false
    @State var hintUsed = false
    @State var showHint = false
    
    @AppStorage("stars") var playerStars: Int = 0
    @AppStorage("playerHint") var hintCount: Int = 0
    @AppStorage("chapters") var savedChapter: [chapter] = populateChapter()
    @AppStorage("levels") var savedLevel: [level] = populateLevel()
    @AppStorage("achievements") var achievementData: [achievement] = populateAchievement()
    @AppStorage("glossaries") var savedGlossaries: [glossary] = populateGlossaries()
    
    @ObservedObject var setUp: GamePlayState
    
    @State var initialPlayerPosition: SCNVector3 = SCNVector3(x: 0, y: -0.234, z: 0)
    
    @ObservedObject var playerInstruction: givenInstruction
    
    let tut: [tutorial] = [tutorial(illustration: "", instruction: "What a huge maze! Adira is stuck in the other side of Eva and Eden!"), tutorial(illustration: "", instruction: "Help Adira find his way through the maze the pathfinding algorithm you have read on the glossary (If you haven't read it, it's advised for you to read it first."), tutorial(illustration: "", instruction: "Arrange the available pieces of algorithm in the Code Editor correctly to find a way through the maze!")]
    
    let choice: [instruction] = [instruction(id: 18, function: .pathFinding, direct: .third), instruction(id: 16, function: .pathFinding, direct: .first), instruction(id: 19, function: .pathFinding, direct: .fourth), instruction(id:17, function: .pathFinding, direct: .second)]
    
    
    var scene = SCNScene(named: "Art.scnassets/Level4Scene.scn")!
    
    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
            }
    
    var playerNode: SCNNode?
    {
        var node: SCNNode
        node = scene.rootNode.childNode(withName: "adira", recursively: true)!
        return node
    }
    
    var coinNode: SCNNode?
    {
        scene.rootNode.childNode(withName: "coin", recursively: true)
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
                    HStack(spacing: 200)
                    {
                        Button {
                            setUp.currentState = .main
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.15, height: geo.size.width * 0.15)
                                
                                Image(systemName: "house.fill").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.05))
                            }
                         
                            
                            
                        }
                        
                        Button {
                            withAnimation {
                                
                                if !hintUsed
                                {
                                    useHint.toggle()
                                }
                                
                                else
                                {
                                    showHint.toggle()
                                }
                            }
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width * 0.15, height: geo.size.width * 0.15)
                                Image("loupe").resizable().frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                            }
                           
                        
                        }.alert("Use hint? (Hint count: \(hintCount))", isPresented: $useHint) {
                            Button("No", role: .cancel) {}
                            Button("Yes", role: .destructive) {
                                
                                hintCount -= 1
                                hintUsed.toggle()
                               //MARK: Add hint
                               
                            }

                        }
                    }
                }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2).position(x: geo.size.width/2, y: geo.size.height * 0.15)
                
                ZStack
                {
                    Rectangle().foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width, height: geo.size.height * 0.07)
                    
                    HStack(spacing: 30)
                    {
                        Button {
                            
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
                                let status = setLevelStatus(instructions: playerInstruction.instructionList, levelID: 4)
                                
                                
                                if status.0 == .cleared
                                {
                                    execute(instructions: playerInstruction.instructionList, player: playerNode!)

                                    
                                    withAnimation{
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 10)
                                        {
                                            if !savedLevel[3].cleared
                                            {
                                                lineCount += status.2
                                                starsCollected += status.1
                                                playerStars += status.1
                                                hintCount += 1
                                                savedLevel[3].starsCount += status.1
                                                savedLevel[3].cleared = true
                                                savedChapter[0].levelDone += 1
                                                achievementData[0].count += status.1
                                                
                                                if !hintUsed
                                                {
                                                    achievementData[1].count += 1
                                                }
                                                
                                                savedGlossaries[3].isUnlocked = true
                                            }
                                            
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
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width, height: geo.size.height * 0.3)
                        
                        VStack(spacing: 30)
                        {
                            
                            Text(tut[index].instruction).foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.03)).multilineTextAlignment(.center).frame(width: geo.size.width * 0.8)
                            
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
                    }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.3).position(x: geo.size.width/2, y: geo.size.height * 0.77)
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
                                           RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.05)
                                           
                                           if choice[i].direct == .first
                                           {
                                               Text("for every node in maze").font(Font.custom("Silom", size: 16)).foregroundColor(Color("whiteAccent"))
                                           }
                                           
                                           else if choice[i].direct == .second
                                           {
                                               Text("if node == goal -> break loop").font(Font.custom("Silom", size: 16)).foregroundColor(Color("whiteAccent"))
                                           }
                                           
                                           else if choice[i].direct == .third
                                           {
                                               Text("if !node isVisited and node value < currentNode").font(Font.custom("Silom", size: 16)).foregroundColor(Color("whiteAccent"))
                                           }
                                           
                                           else if choice[i].direct == .fourth
                                           {
                                               Text("currentNode = node").font(Font.custom("Silom", size: 16)).foregroundColor(Color("whiteAccent"))
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
                                        setUp.currentState = .main
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
                
                if showHint
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.6)
                        
                        VStack
                        {
                            Image("Mascot - Cody").resizable().frame(width: geo.size.width * 0.5, height: geo.size.height * 0.25)
                            
                            Text("Check every single node and save the one with lowest value, that's pathfinding!").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("mainPurple")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.7)
                        }
                        
                       
                        
                    }.position(x: geo.size.width/2, y: geo.size.height/2)
                }
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Level4_Previews: PreviewProvider {
    static var previews: some View {
        Level4(setUp: GamePlayState(), playerInstruction: givenInstruction())
    }
}
