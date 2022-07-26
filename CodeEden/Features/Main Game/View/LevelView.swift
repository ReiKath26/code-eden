//
//  LevelView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct LevelView: View {
    
    
    @Binding var level: Level?
    
    
    var body: some View {
       GeometryReader
        {
            geo in
            
            VStack
            {
                ZStack
                {
                    Circle().frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5).foregroundColor(Color("whiteAccent"))
                    
                    VStack(spacing: -30)
                    {
                        Text("\(Int(level?.levelID ?? 1))").foregroundColor(Color("mainPurple")).font(Font.custom("Silom", size: geo.size.width * 0.3))
                        

                        if level?.isDone == true
                        {
                            Image("star").resizable().frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)

                        }

                     
                    }
                  
                }
                
                Text("\(Int(level?.stars ?? 0))/3").foregroundColor(Color("whiteAccent")).font(Font.custom("Silom", size: geo.size.width * 0.1))
            }.position(x: geo.size.width/2, y: geo.size.height/2)
            
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(level: .constant(DataMockStore().gamePlayMockStore(context: DataMockStore().container.viewContext).levels.first))
    }
}
