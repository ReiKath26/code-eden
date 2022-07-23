//
//  GlossaryCardView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct GlossaryCardView: View {
    
    let title: String
    let cover: String
    var body: some View {
        GeometryReader
        {
            geo in
            
            ZStack
            {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width, height: geo.size.height)
                
                VStack
                {
                    Image(cover).resizable().frame(width: geo.size.width, height: geo.size.height * 0.7)
                    
                    Text(title).foregroundColor(Color("mainPurple")).font(Font.custom("Silom", size: geo.size.width * 0.07))
                }.position(x: geo.size.width/2, y: geo.size.height/3)
            }
        }
    }
}

struct GlossaryCardView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryCardView(title: "Struct vs Class", cover: "Mascot - Cody")
    }
}
