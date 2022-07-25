//
//  GlossaryView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct GlossaryView: View {

    @Binding var glossaries: [Glossary]
    @State var alertShown = false
    @State var readGlossary = false
    
    @State var index = 0
    
    var body: some View {
        
       
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                VStack (spacing: 30)
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius: 5).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2).foregroundColor(Color("darkPurpleAccent"))
                        VStack(spacing: -20)
                        {
                            Image("Mascot - Cody").resizable().frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                            
                            Text( "Cody loves reading! Anything interesting you want to read with Cody today?" ).font(Font.custom("Silom", size: geo.size.width * 0.04)).foregroundColor(Color("whiteAccent")).multilineTextAlignment(.center).frame(width: geo.size.width * 0.7, height: geo.size.height * 0.1)
                        }

                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                    VStack(spacing: 30)
                    {
                        ForEach(0..<glossaries.count)
                        {
                            i in
                                Button {
                                    if glossaries[i].isUnlocked
                                    {
                                        withAnimation {
                                            readGlossary.toggle()
                                            index = i
                                        }
                                    }
                                    else
                                    {
                                        withAnimation {
                                            alertShown.toggle()
                                        }
                                       
                                    }
                                } label: {
                                    if glossaries[i].isUnlocked
                                    {
                                        GlossaryCardView(title: glossaries[i].title ?? "Loading title...", cover: glossaries[i].cover ?? "Intro Cover")
                                    }
                                    
                                    else
                                    {
                                        LockedCardView(title: "Chapter \((glossaries[i].level?.levelID ?? 111) - 100)").frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                                    }
                                }.alert("Complete presequite challenge to unlock!", isPresented: $alertShown) {
                                    Button("Okay", role: .cancel) {}
                                }
                            }
                           
                        }
                        

                    }
                }.position(x: geo.size.width/2, y: geo.size.height/2).frame( height: geo.size.height * 0.9)
                
            }
            
            if readGlossary
            {
                ReadGlossary(thisGlossary: .constant(glossaries[index]))
            }
        }
    }
}

struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView(glossaries: .constant(DataMockStore().gamePlayMockStore(context: DataMockStore().container.viewContext).glossaries))
    }
}
