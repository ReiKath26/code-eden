//
//  CircularProgressBar.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct CircularProgressBar: View {
    
    @Binding var progress: Float
    var icon: String
    
    var body: some View {
        
        GeometryReader
        {
            geo in
            
            ZStack {
                        Circle()
                    .stroke(lineWidth: geo.size.width * 0.04)
                            .opacity(0.3)
                            .foregroundColor(Color("mainPurple"))
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: geo.size.width * 0.04, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("mainPurple"))
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.linear)
                
                Image(icon).resizable().frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)

                       
            }.frame(width: geo.size.width * 0.8, height: geo.size.width * 0.8).position(x: geo.size.width/2, y: geo.size.width/2)
        }
        
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar(progress: .constant(0.3), icon: "star")
    }
}
