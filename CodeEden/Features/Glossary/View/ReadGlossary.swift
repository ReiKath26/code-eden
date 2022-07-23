//
//  ReadGlossary.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct ReadGlossary: View {
    
    
    var body: some View {
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 10).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.8).foregroundColor(Color("whiteAccent"))
                    
                    VStack
                    {
                        Image("Mascot - Eva").resizable().frame(width: geo.size.width * 0.9, height: geo.size.height * 0.2)
                        
                        Text("Title").font(Font.custom("Silom", size: 30)).foregroundColor(Color("mainPurple"))
                        
                        Text("Desc").font(Font.custom("Silom", size: 18)).foregroundColor(Color("mainPurple")).frame(width: geo.size.width * 0.7, height: geo.size.height * 0.3)
                        
                        HStack(spacing: 50)
                        {
                            Button {
                                
                            } label: {
                                Image(systemName: "arrowshape.turn.up.backward.fill").font(.system(size: 24)).foregroundColor(Color("mainPurple"))
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "headphones").font(.system(size: 24)).foregroundColor(Color("mainPurple"))
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "forward.fill").font(.system(size: 24)).foregroundColor(Color("mainPurple"))
                            }

                        }
                    }
                    
                  
                    
                    
                }.position(x: geo.size.width/2, y: geo.size.height/2)
            }
        }
    }
}

struct ReadGlossary_Previews: PreviewProvider {
    static var previews: some View {
        ReadGlossary()
    }
}
