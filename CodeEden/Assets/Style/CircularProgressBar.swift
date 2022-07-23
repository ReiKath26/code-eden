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
        ZStack {
                    Circle()
                        .stroke(lineWidth: 30.0)
                        .opacity(0.3)
                        .foregroundColor(Color("mainPurple"))
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("mainPurple"))
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear)
            
                    Image(icon).resizable().frame(width: 300, height: 300)

                   
                }
    }
}

//struct CircularProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularProgressBar(progress: 0.3)
//    }
//}
