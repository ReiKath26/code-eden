//
//  MainMenu.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct MainMenu: View {
    
    @Binding var chapters: [Chapter]
    @Binding var player: Player?
    @State var index = 0
    @State var showLevelSelect = false
    @State var mode = "Normal"
    var modes = ["Normal", "Hard"]
    
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
                        Text("What are we going to learn today?").font(Font.custom("Silom", size: geo.size.width * 0.05)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.8)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack(spacing: 60)
                            {
                                HStack
                                {
                                    
                                        ForEach(0..<chapters.count)
                                        {
                                            i in
                                            
                                            Button {
                                                withAnimation {
                                                    showLevelSelect.toggle()
                                                    index = i
                                                }
                                            } label: {
                                                
                                                VStack
                                               {
                                                   CircularProgressBar(progress: .constant(chapters[i].progress), icon: chapters[i].icon ?? "Mascot - Cody").frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                                                   
                                                   Text(chapters[i].title ?? "Loading chapter...").font(Font.custom("Silom", size: geo.size.width * 0.035)).foregroundColor(Color("whiteAccent"))
                                                }
                                            }

                                         
                                            
                                        }
                                    
                                }
                                
                                Text("More Coming Soon").font(Font.custom("Silom", size: geo.size.width * 0.07)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).opacity(0.5).frame(width: geo.size.width * 0.6)
                            }
                           
                            
                        }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.5)
                        
                    }
                }.position(x: geo.size.width/2, y: geo.size.height/2)
            }
          
            if showLevelSelect
            {
                LevelSelectView(levels: .constant(DataMockStore().levelOfChapter(chapter: chapters[index]).sorted
                {
                    $0.levelID < $1.levelID
                }), player: .constant(player) )
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(chapters: .constant(DataMockStore().gamePlayMockStore(context: DataMockStore().container.viewContext).chapters), player: .constant(DataMockStore().newPlayer(name: "User", avatar: "Mascot - Adira", context: DataMockStore().container.viewContext)))
    }
}
