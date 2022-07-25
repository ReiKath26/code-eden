//
//  LockedCardView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct LockedCardView: View {
    
    let title: String
    var body: some View {
        GeometryReader
        {
            geo in
            
            ZStack
            {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("whiteAccent")).frame(width: geo.size.width, height: geo.size.height)
                
                VStack(spacing: 20)
                {
                    Image(systemName: "lock.fill").font(Font.custom("Silom", size: geo.size.width * 0.15)).foregroundColor(Color("mainPurple"))
                    
                    Text("Unlock after clearing \(title)").foregroundColor(Color("mainPurple")).font(Font.custom("Silom", size: geo.size.width * 0.07)).multilineTextAlignment(.center)
                }.position(x: geo.size.width/2, y: geo.size.height * 0.5)
            }
        }
    }
}

struct LockedCardView_Previews: PreviewProvider {
    static var previews: some View {
        LockedCardView(title: "Chapter 1-2")
    }
}
