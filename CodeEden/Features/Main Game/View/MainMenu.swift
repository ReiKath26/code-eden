//
//  MainMenu.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct MainMenu: View {
    
    @ObservedObject var gameSetting: GamePlayState
    @StateObject var selectLevel = presentMode()
    @State var showAlert = false
    @State var index = 0
    @State var mode = "Normal"
    var modes = ["Normal", "Hard"]
    
    @AppStorage("chapters") var savedChapter: [chapter] = populateChapter()
    
    var body: some View {
       ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                if UIDevice.current.userInterfaceIdiom == .phone
                {
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
                                        
                                        ForEach(0..<savedChapter.count)
                                            {
                                                i in
                                                
                                                Button {
                                                    withAnimation {
                                                        
                                                        if i == 0 || savedChapter[i-1].levelDone/savedChapter[i-1].levelCount == 1
                                                        {
                                                            selectLevel.isShown.toggle()
                                                            index = i
                                                        }
                                                        
                                                        else
                                                        {
                                                            showAlert.toggle()
                                                        }
                                                        
                                                    }
                                                } label: {
                                                    
                                                    VStack
                                                   {
                                                       CircularProgressBar(progress: .constant(Float(Float(savedChapter[i].levelDone) / Float(savedChapter[i].levelCount))), icon: savedChapter[i].icon).frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                                                       
                                                       Text(savedChapter[i].title).font(Font.custom("Silom", size: geo.size.width * 0.035)).foregroundColor(Color("whiteAccent"))
                                                    }.alert("Complete previous chapter to unlock!", isPresented: $showAlert) {
                                                        Button("Okay", role: .cancel) {}
                                                        
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
                
                else if UIDevice.current.userInterfaceIdiom == .pad
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color(mode == "Normal" ? "darkPurpleAccent" : "reddishPink")).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.5).opacity(0.7)
                        
                        VStack
                        {
                            Text("What are we going to learn today?").font(Font.custom("Silom", size: geo.size.width * 0.05)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.8)
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                VStack(spacing: 60)
                                {
                                    HStack
                                    {
                                        
                                        ForEach(0..<savedChapter.count)
                                            {
                                                i in
                                                
                                                Button {
                                                    withAnimation {
                                                        
                                                        if i == 0 || savedChapter[i-1].levelDone/savedChapter[i-1].levelCount == 1
                                                        {
                                                            selectLevel.isShown.toggle()
                                                            index = i
                                                        }
                                                        
                                                        else
                                                        {
                                                            showAlert.toggle()
                                                        }
                                                        
                                                    }
                                                } label: {
                                                    
                                                    VStack
                                                   {
                                                       CircularProgressBar(progress: .constant(Float(Float(savedChapter[i].levelDone) / Float(savedChapter[i].levelCount))), icon: savedChapter[i].icon).frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                                                       
                                                       Text(savedChapter[i].title).font(Font.custom("Silom", size: geo.size.width * 0.035)).foregroundColor(Color("whiteAccent"))
                                                    }.alert("Complete previous chapter to unlock!", isPresented: $showAlert) {
                                                        Button("Okay", role: .cancel) {}
                                                        
                                                    }
                                                }

                                             
                                                
                                            }
                                        
                                    }
                                    
                                    Text("More Coming Soon").font(Font.custom("Silom", size: geo.size.width * 0.07)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).opacity(0.5).frame(width: geo.size.width * 0.6)
                                }
                               
                                
                            }.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.5)
                            
                        }.position(x: geo.size.width/2, y: geo.size.height * 0.57)
                    }.position(x: geo.size.width/2, y: geo.size.height * 0.47)
                }
                
               
            }
          
            if selectLevel.isShown
            {
                LevelSelectView(setUp: gameSetting, selectLevel: selectLevel, index: index)
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(gameSetting: GamePlayState())
    }
}

