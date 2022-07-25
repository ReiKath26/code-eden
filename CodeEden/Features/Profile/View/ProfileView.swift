//
//  ProfileView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var edit = false
    @Binding var player: Player?
    
    var achievement : [Achievement] = DataMockStore().achievementMockStore(context: DataMockStore().container.viewContext)
    var body: some View {
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                ZStack
                {
                    VStack
                    {
                        Image(player?.avatar ?? "Mascot - Cody").resizable().frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                        
                        Text(player?.name ?? "Loading name...").font(Font.custom("Silom", size: 24)).foregroundColor(Color("whiteAccent"))
                        
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 20).frame(width: geo.size.width * 0.3, height: geo.size.height * 0.03).foregroundColor(Color("whiteAccent"))
                            HStack(spacing: 10)
                            {
                                Image("star").resizable().frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                                
                                Text("\(Int(player?.stars ?? 0))").font(Font.custom("Silom", size: 20)).foregroundColor(Color("mainPurple"))
                            }
                        }
                        
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.45).foregroundColor(Color("whiteAccent"))
                            
                            VStack(spacing: 20)
                            {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame( height: geo.size.height * 0.1)
                                    Text("My Achievement").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: 20))
                                }
                             
                                    ScrollView(.vertical, showsIndicators:false)
                                    {
                                        ForEach(0..<achievement.count)
                                        {
                                            i in
                                            
                                            HStack
                                            {
                                                CircularProgressBar(progress: .constant(achievement[i].progress), icon: achievement[i].icon ?? "star").frame(width: geo.size.width * 0.3, height: geo.size.width * 0.3)
                                                
                                                Text(achievement[i].desc ?? "Loading desc...").font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.4)
                                            }
                                        }
                                    }
                                
                                
                               
                            }
                        }.frame(width: geo.size.width * 0.9, height: geo.size.height * 0.45)
                       
                        
                        
                    }.position(x: geo.size.width/2, y: geo.size.height/2)

                }
            }
            
            Button {
                withAnimation {
                    edit.toggle()
                }
                
            } label: {
                
                GeometryReader
                {
                    geo in
                    ZStack
                    {
                        
                        RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.25, height: geo.size.height * 0.05).foregroundColor(Color("whiteAccent"))
                        
                        Image(systemName: "pencil").foregroundColor(Color("mainPurple")).font(.system(size: 40))
                    }.position(x: geo.size.width * 0.8, y: geo.size.height * 0.07)
                }
              
               
            }.sheet(isPresented: $edit) {
                EditProfileView(name: player?.name ?? "", index: .constant(player?.avatar == "Mascot - Adira" ? 0 : 1), player: $player)
            }


        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(player: .constant(DataMockStore().newPlayer(name: "User", avatar: "Mascot - Adira", context: DataMockStore().container.viewContext)))
    }
}
