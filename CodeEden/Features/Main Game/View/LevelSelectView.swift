//
//  LevelSelectView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct LevelSelectView: View {
    
    @State var mode = "Normal"
    @Binding var levels: [Level]
    
    var body: some View {
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(Color(mode == "Normal" ? "darkPurpleAccent" : "reddishPink")).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.8).opacity(0.7)
                }.position(x: geo.size.width/2, y: geo.size.height/2)
            }
        }
    }
}

struct LevelSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectView()
    }
}
