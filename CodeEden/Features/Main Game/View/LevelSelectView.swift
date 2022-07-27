//
//  LevelSelectView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct LevelSelectView: View {
    
    
    @ObservedObject var setUp: GamePlayState
    @State var mode = "Normal"
    @State var levelIsLocked = false
    @State var playGame = false
    @State var levelIndex = 1
    @State var index = 0
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("chapters") var savedChapter: [chapter] = populateChapter()
    
    @AppStorage("levels") var savedLevel: [level] = populateLevel()
    @AppStorage("playerHint") var hintCount: Int = 0
    
    var body: some View {
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                ZStack {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color(mode == "Normal" ? "darkPurpleAccent" : "reddishPink")).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.8).opacity(0.7)
                        
                        VStack
                        {
                            HStack(spacing: 110)
                            {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "arrowshape.turn.up.backward.fill").foregroundColor(Color("whiteAccent")).font(.system(size: geo.size.width * 0.07))
                                }
                                
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: 20).frame(width: geo.size.width * 0.3, height: geo.size.height * 0.03).foregroundColor(Color("whiteAccent"))
                                    HStack(spacing: 10)
                                    {
                                        Image("loupe").resizable().frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                                        
                                        Text("\(hintCount)").font(Font.custom("Silom", size: 20)).foregroundColor(Color("mainPurple"))
                                    }
                                }
                                
                                

                            }
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack
                                {
                                    CircularProgressBar(progress: .constant(Float(savedChapter[index].levelDone/savedChapter[index].levelCount)), icon: savedChapter[index].icon).frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                                    
                                    Text(savedChapter[index].title).font(Font.custom("Silom", size: geo.size.width * 0.035)).foregroundColor(Color("whiteAccent"))
                                    
                                    Button {
                                        
                                    } label: {
                                        
                                        ZStack
                                        {
                                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.3, height: geo.size.height * 0.04)
                                            
                                            Text("Tips").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.06))
                                        }
                                     
                                    }
                                    
                                    ForEach(0..<(savedLevel.count))
                                    {
                                        i in
                                        
                                        if savedLevel[i].chapter_id == index + 1
                                        {
                                            if i == 0
                                            {
                                                Button {
                                                    withAnimation {
                                                        setUp.currentState = .play
                                                        playGame.toggle()
                                                    }
                                                } label: {
                                                    LevelView(thisLevel: savedLevel[i]).frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                                                }
                                            }
                                            
                                            else
                                            {
                                                if savedLevel[i-1].cleared
                                                {
                                                    Button {
                                                        withAnimation {
                                                            setUp.currentState = .play
                                                            playGame.toggle()
                                                        }
                                                    } label: {
                                                        LevelView(thisLevel: savedLevel[i]).frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                                                    }
                                                }
                                                
                                                else
                                                {
                                                    Button {
                                                        withAnimation {
                                                            levelIsLocked.toggle()
                                                        }
                                                    } label: {
                                                        LockedLevelView().frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                                                    }.alert("Complete presequite challenge to unlock!", isPresented: $levelIsLocked) {
                                                        Button("Okay", role: .cancel) {}

                                                }
                                            }
                                           
                                        }
                                         
                                     }

                                        
                                    }

                                }
                            }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.65)
                        }
                }.position(x: geo.size.width/2, y: geo.size.height/2)
                    
                    if playGame
                    {
                        switch levelIndex
                        {
                            case 1:
                                Level1(playerInstruction: givenInstruction())
                            case 2:
                                Level2()
                            case 3:
                                Level3()
                            case 4:
                                Level4()
                        default:
                            Level1(playerInstruction: givenInstruction())
                        }
                    }
                   
                }
            }
        }
    }
}

struct LevelSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectView(setUp: GamePlayState())
    }
}
