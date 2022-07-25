//
//  OnboardingViewFirst.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct mode: Identifiable
{
    let id = UUID()
    let icon: String
    let title: String
    let desc: String
}

struct OnboardingViewFirst: View {
    
    @State private var index = 0
    @State private var name : String = ""
    @State private var count = 1
    @State var newPlayer: Player?
    
    @AppStorage("userStatus") var status: Bool = false
    
    let modes: [mode] = ModeMockStore.modes
    
    var avatar = ["Mascot - Adira", "Mascot - Eva"]
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        
        ZStack
        {
            MainView(player: $newPlayer)
        
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            GeometryReader
            {
                geo in
                VStack(spacing: geo.size.height * 0.03)
                {
                    ProgressView("", value: count == 1 ? 0.5 : 1, total: 1).progressViewStyle(CustomProgressStyle(stroke: Color("whiteAccent"), fill: Color("mainPurple"), caption: "", cornerRadius: 5, width: geo.size.width * 0.8,height: geo.size.height * 0.02, animation: Animation.easeOut))
                    

                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 5).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.15).foregroundColor(Color("darkPurpleAccent"))
                            VStack(spacing: -20)
                            {
                                Image("Mascot - Cody").resizable().frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                
                                Text(count == 1 ? "Welcome to Code Eden! I’m Cody, how may I call you?" : "Nice to meet you, \(name)! Before we start, please choose your path").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.7, height: geo.size.height * 0.1)
                            }
        
                        }
                    
                    if count == 1
                    {
                        
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
                            withAnimation {
                                count = 2
                            }
                        } label: {
                            
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.7, height: geo.size.height * 0.05)
                                
                                Text("Continue").font(Font.custom("Silom", size: 16)).foregroundColor(Color("whiteAccent"))
                            }
                           
                        }.disabled(!name.isEmpty ? false: true)
                    }
                    
                    if count == 2
                    {
                        ForEach(0..<modes.count)
                        {
                            i in
                            
                            Button {
                                withAnimation(Animation.easeOut(duration: 0.45)) {
                                    status = true
                                    
                                    newPlayer = DataMockStore().newPlayer(name: name, avatar: avatar[index], context: managedObjectContext)
                                }
                            } label: {
                                ChooseModeCardView(title: modes[i].title, icon: modes[i].icon, desc: modes[i].desc).frame(width: geo.size.width * 0.85, height: geo.size.height * 0.2)
                            }

                            
                        }
                    }
                   

                    
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
