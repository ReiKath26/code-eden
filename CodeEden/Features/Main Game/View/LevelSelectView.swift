//
//  LevelSelectView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct LevelSelectView: View {
    
    @StateObject var setUp = GamePlayState()
    
    @State var mode = "Normal"
    @State var levelIsLocked = false
    
    @Binding var levels: [Level]
    @Binding var player: Player?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
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
                                    
                                    Text("\(Int(player?.hint ?? 1))").font(Font.custom("Silom", size: 20)).foregroundColor(Color("mainPurple"))
                                }
                            }
                            
                            

                        }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack
                            {
                                CircularProgressBar(progress: .constant(levels[0].chapter?.progress ?? 0), icon: levels[0].chapter?.icon ?? "Mascot - Cody").frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                                
                                Text(levels[0].chapter?.title ?? "Loading chapter...").font(Font.custom("Silom", size: geo.size.width * 0.035)).foregroundColor(Color("whiteAccent"))
                                
                                Button {
                                    
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.3, height: geo.size.height * 0.04)
                                        
                                        Text("Tips").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.06))
                                    }
                                 
                                }
                                
                                ForEach(0..<(levels.count))
                                {
                                    i in
                                    
                                    if i == 0
                                    {
                                        Button {
                                            withAnimation {
                                                setUp.currentState = .play
//                                                setUp.levelID = levels[i].levelID
                                            }
                                        } label: {
                                            LevelView(level: .constant(levels[i])).frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                                        }

                                        
                                    }
                                    
                                    else
                                    {
                                        if !levels[i-1].isDone
                                        {
                                            Button {
                                                levelIsLocked.toggle()
                                            } label: {
                                                LockedLevelView().frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                                            }.alert("Complete presequite level to unlock!", isPresented: $levelIsLocked) {
                                                Button("Okay", role: .cancel) {}
                                            }

                                           
                                        }
                                        
                                        else
                                        {
                                            Button {
                                                withAnimation {
                                                    setUp.currentState = .play
//                                                    setUp.levelID = levels[i].levelID
                                                }
                                            } label: {
                                                LevelView(level: .constant(levels[i])).frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                                            }

                                            
                                        }
                                    }
                                }

                            }
                        }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.65)
                    }
                }.position(x: geo.size.width/2, y: geo.size.height/2)
            }
        }
    }
}

struct LevelSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectView(levels: .constant(DataMockStore().levelOfChapter(chapter: DataMockStore().gamePlayMockStore(context: DataMockStore().container.viewContext).chapters.first!).sorted
                                          {
            $0.levelID < $1.levelID
        }), player: .constant(DataMockStore().newPlayer(name: "User", avatar: "Mascot - Adira", context: DataMockStore().container.viewContext)))
    }
}
