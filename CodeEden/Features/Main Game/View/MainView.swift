//
//  MainView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

enum state
{
    case main
    case glossary
    case profile
}

struct MainView: View {
    
    @StateObject var gameState = GamePlayState()
    @State var currentState: state = .main
    @Binding var player: Player?
    
    let mockStore = DataMockStore().gamePlayMockStore(context: DataMockStore().container.viewContext)
    
    var body: some View {
        ZStack
        {
            if gameState.currentState == .main
            {
                if currentState == .main
                {
                    MainMenu(mockStore: mockStore, gameSetting: gameState)
                }
                
                else if currentState == .glossary
                {
                    GlossaryView(glossaries: .constant(DataMockStore().gamePlayMockStore(context: DataMockStore().container.viewContext).glossaries))
                }
                
                else
                {
                    ProfileView(player: $player)
                }
            }
            
            else
            {
                switch gameState.levelID
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
            
            GeometryReader
            {
                geo in
                
                ZStack
                {
                    Rectangle().foregroundColor(Color("darkPurpleAccent")).frame(width: geo.size.width, height: geo.size.height * 0.07)
                    
                    HStack(spacing: 30)
                    {
                        Button {
                            
                            if gameState.currentState == .main
                            {
                                withAnimation(Animation.easeOut(duration: 0.3)) {
                                    currentState = .glossary
                            }
                                
                            }
                                
                            else
                            {
                                //MARK: Reset game logic
                            }
                                
                            
    
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .glossary ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .glossary ? "mainPurple" : "whiteAccent"))
                                
                                Image(systemName: gameState.currentState == .main ?  "books.vertical.fill" : "arrow.clockwise").font(.system(size: currentState == .glossary ? geo.size.width * 0.1 : geo.size.width * 0.05)).foregroundColor(Color(currentState == .glossary ? "whiteAccent" : "mainPurple"))
                            }
                        }
                        
                        Button {
                            
                            if gameState.currentState == .main
                            {
                                withAnimation(Animation.easeOut(duration: 0.3)) {
                                    currentState = .main
                                }
                            }
                            
                            else
                            {
                                //MARK: play code result
                            }
                            
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .main ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .main ? "mainPurple" : "whiteAccent"))
                                
                                Image(systemName: gameState.currentState == .main ?  "play.circle.fill" : "play.square.fill").font(.system(size: currentState == .main ? geo.size.width * 0.1 : geo.size.width * 0.05)).foregroundColor(Color(currentState == .main ? "whiteAccent" : "mainPurple"))
                            }
                        }
                        
                        Button {
                            
                            if gameState.currentState == .main
                            {
                                withAnimation(Animation.easeOut(duration: 0.3)) {
                                    currentState = .profile
                                }
                            }
                            
                            else
                            {
                                //MARK: open code editor
                            }
                            
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.22, height: currentState == .profile ? geo.size.height * 0.07 : geo.size.height * 0.05).foregroundColor(Color(currentState == .profile ? "mainPurple" : "whiteAccent"))
                                
                                Image(systemName: gameState.currentState == .main ?  "person.fill" : "chevron.left.forwardslash.chevron.right").font(.system(size: currentState == .profile ? geo.size.width * 0.1 : geo.size.width * 0.07)).foregroundColor(Color(currentState == .profile ? "whiteAccent" : "mainPurple"))
                            }
                        }
                        
                     
                    }
                }.frame(width: geo.size.width, height: geo.size.height * 0.06, alignment: .bottom).position(x: geo.size.width/2, y: geo.size.height * 0.96)
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(player: .constant(DataMockStore().newPlayer(name: "User", avatar: "Mascot - Adira", context: DataMockStore().container.viewContext)))
    }
}
