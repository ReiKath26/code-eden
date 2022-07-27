//
//  OnboardingViewFirst.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct OnboardingViewFirst: View {
    
    @State private var index = 0
    @State private var name : String = ""
    @AppStorage("username") var playerName: String = ""
    @AppStorage("userAvatar") var avatarName: String = ""
    @AppStorage("userStatus") var status: Bool = false
    
    var avatar = ["Mascot - Adira", "Mascot - Eva"]
    
    var body: some View {
        
        ZStack
        {
            MainView()
        
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            GeometryReader
            {
                geo in
                VStack(spacing: geo.size.height * 0.03)
                {
                   
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 5).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.15).foregroundColor(Color("darkPurpleAccent"))
                            VStack(spacing: -20)
                            {
                                Image("Mascot - Cody").resizable().frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                
                                Text("Welcome to Code Eden! I’m Cody, how may I call you?").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.7, height: geo.size.height * 0.1)
                            }
        
                        }
                    
                        
                        HStack
                        {
                            Button {
                                withAnimation {
                                    index = 0
                                }
                                
                            } label: {
                                Image(systemName: "arrowtriangle.backward.fill").foregroundColor(Color("mainPurple"))
                            }
                            
                            
                            Image(avatar[index]).resizable().frame(width: geo.size.width * 0.6, height: geo.size.width * 0.6)
                            
                            
                            Button {
                                withAnimation {
                                    index = 1
                                }
                            } label: {
                                Image(systemName: "arrowtriangle.forward.fill").foregroundColor(Color("mainPurple"))
                            }


                        }
                        
                        TextField("Enter your name here...", text: $name).background().textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: geo.size.width * 0.8, height: geo.size.width * 0.1).font(Font.custom("Silom", size: 16))
                        
                        Button {
                            
                            playerName = name
                            avatarName = avatar[index]
                            
                            withAnimation {
                                status.toggle()
                            }
                            
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.7, height: geo.size.height * 0.05)
                                
                                Text("Continue").font(Font.custom("Silom", size: 16)).foregroundColor(Color("whiteAccent"))
                            }
                           
                        }.disabled(!name.isEmpty ? false: true)


                    
                }.position(x: geo.size.width/2, y: geo.size.height/2)
            }
           
        }.opacity(status ? 0 : 1)
            
        }
    }
}

struct OnboardingViewFirst_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingViewFirst()
    }
}
