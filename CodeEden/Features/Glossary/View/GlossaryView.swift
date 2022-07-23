//
//  GlossaryView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct GlossaryView: View {
    var body: some View {
        ZStack
        {
            Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
            GeometryReader
            {
                geo in
                
                VStack
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
                        //MARK: add material collectionview & logic
                    }
                }.position(x: geo.size.width/2, y: geo.size.height/2).frame( height: geo.size.height * 0.9)
                
            }
        }
    }
}

struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
