//
//  MainView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI
import AVFoundation

enum state
{
    case main
    case glossary
    case profile
}

struct MainView: View {
    
    @StateObject var gameState = GamePlayState()
    @State var currentState: state = .main
    
    
    var body: some View {
        ZStack
        {
           
            
                if currentState == .main
                {
                    MainMenu(gameSetting: gameState)
                }
                
                else if currentState == .glossary
                {
                    GlossaryView()
                }
                
                else
                {
                    ProfileView()
                }
            
            if gameState.currentState == .main
            {
                
            
                GeometryReader
                {
                    geo in
                    
                    if UIDevice.current.userInterfaceIdiom == .phone
                    {
                        ZStack
                        {
                            Rectangle().foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width, height: geo.size.height * 0.07)
                            
                            HStack(spacing: 30)
                            {
                                Button {
                                    
                                    withAnimation(Animation.easeOut(duration: 0.3)) {
                                            currentState = .glossary
                                    }
                                        
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .glossary ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .glossary ? "mainPurple" : "whiteAccent"))
                                        
                                        Image(systemName:   "books.vertical.fill").font(.system(size: currentState == .glossary ? geo.size.width * 0.1 : geo.size.width * 0.05)).foregroundColor(Color(currentState == .glossary ? "whiteAccent" : "mainPurple"))
                                    }
                                }
                                
                                Button {
                                
                                withAnimation(Animation.easeOut(duration: 0.3)) {
                                            currentState = .main
                                        }
                                    
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .main ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .main ? "mainPurple" : "whiteAccent"))
                                        
                                        Image(systemName:  "play.circle.fill").font(.system(size: currentState == .main ? geo.size.width * 0.1 : geo.size.width * 0.05)).foregroundColor(Color(currentState == .main ? "whiteAccent" : "mainPurple"))
                                    }
                                }
                                
                                Button {
                                
                                withAnimation(Animation.easeOut(duration: 0.3)) {
                                            currentState = .profile
                                        }
                                 
                                
                                    
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .profile ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .profile ? "mainPurple" : "whiteAccent"))
                                        
                                        Image(systemName: "person.fill").font(.system(size: currentState == .profile ? geo.size.width * 0.1 : geo.size.width * 0.07)).foregroundColor(Color(currentState == .profile ? "whiteAccent" : "mainPurple"))
                                    }
                                }
                                
                             
                            }
                        }.frame(width: geo.size.width, height: geo.size.height * 0.06, alignment: .bottom).position(x: geo.size.width/2, y: geo.size.height * 0.96)
                    }
                    
                    else if UIDevice.current.userInterfaceIdiom == .pad
                    {
                        ZStack
                        {
                            Rectangle().foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width, height: geo.size.height * 0.07)
                            
                            HStack(spacing: 30)
                            {
                                Button {
                                    
                                    withAnimation(Animation.easeOut(duration: 0.3)) {
                                            currentState = .glossary
                                    }
                                        
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .glossary ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .glossary ? "mainPurple" : "whiteAccent"))
                                        
                                        Image(systemName:   "books.vertical.fill").font(.system(size: currentState == .glossary ? geo.size.width * 0.1 : geo.size.width * 0.05)).foregroundColor(Color(currentState == .glossary ? "whiteAccent" : "mainPurple"))
                                    }
                                }
                                
                                Button {
                                
                                withAnimation(Animation.easeOut(duration: 0.3)) {
                                            currentState = .main
                                        }
                                    
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .main ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .main ? "mainPurple" : "whiteAccent"))
                                        
                                        Image(systemName:  "play.circle.fill").font(.system(size: currentState == .main ? geo.size.width * 0.1 : geo.size.width * 0.05)).foregroundColor(Color(currentState == .main ? "whiteAccent" : "mainPurple"))
                                    }
                                }
                                
                                Button {
                                
                                withAnimation(Animation.easeOut(duration: 0.3)) {
                                            currentState = .profile
                                        }
                                 
                                
                                    
                                } label: {
                                    
                                    ZStack
                                    {
                                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .profile ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .profile ? "mainPurple" : "whiteAccent"))
                                        
                                        Image(systemName: "person.fill").font(.system(size: currentState == .profile ? geo.size.width * 0.1 : geo.size.width * 0.07)).foregroundColor(Color(currentState == .profile ? "whiteAccent" : "mainPurple"))
                                    }
                                }
                                
                             
                            }
                        }.frame(width: geo.size.width, height: geo.size.height * 0.06, alignment: .bottom).position(x: geo.size.width/2, y: geo.size.height * 0.8)
                    }
                    
                  
                    
                }
                
            }
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
