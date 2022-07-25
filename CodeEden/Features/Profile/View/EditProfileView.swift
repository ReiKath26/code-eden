//
//  EditProfileView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var name = ""
    @Binding var index: Int
    var avatar = ["Mascot - Adira", "Mascot - Eva"]
    @Binding var player : Player?
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                VStack(spacing: 30)
                {
                    

                    Text("Edit Profile").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: 24))
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
                            
                        DataMockStore().editProfile(player: player!, name: name, avatar: avatar[index], context: managedObjectContext)
                        
                        dismiss()
                    } label: {
                        
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.7, height: geo.size.height * 0.05)
                            
                            Text("Save").font(Font.custom("Silom", size: 16)).foregroundColor(Color("whiteAccent"))
                        }
                       
                    }.disabled(!name.isEmpty ? false: true)
                }.position(x: geo.size.width/2, y: geo.size.height/2)
            }
        }
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(index: .constant(0), player: .constant(DataMockStore().newPlayer(name: "User", avatar: "Mascot - Adira", context: DataMockStore().container.viewContext)))
    }
}
