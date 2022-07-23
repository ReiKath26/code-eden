//
//  ChooseModeCardView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct ChooseModeCardView: View {
    
    let title: String
    let icon: String
    let desc: String
    
    var body: some View {
        
        GeometryReader
        {
            geo in
            
            ZStack
            {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width, height: geo.size.height)
                
                HStack
                {
                    Image(icon).resizable().frame(width: geo.size.width * 0.3, height: geo.size.height * 0.7)
                    
                    VStack
                    {
                        Text(title).foregroundColor(Color("mainPurple")).font(Font.custom("Silom", size: geo.size.width * 0.07))
                        Text(desc).foregroundColor(Color("darkGreyAccent")).font(Font.custom("Silom", size: geo.size.height * 0.06))
                    }.frame(width: geo.size.width * 0.5, height: geo.size.height * 0.7)
                }
            }
        }
       
    }
}

struct ChooseModeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseModeCardView(title: "New to Code", icon: "Mascot - Cody", desc: "Learn from the Basics")
    }
}
