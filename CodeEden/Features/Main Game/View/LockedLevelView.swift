//
//  LockedLevelView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 23/07/22.
//

import SwiftUI

struct LockedLevelView: View {
    var body: some View {
        GeometryReader
        {
            geo in
            
            ZStack
            {
                Circle().frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5).foregroundColor(Color("darkGreyAccent"))
                Image(systemName: "lock.fill").foregroundColor(Color("whiteAccent")).font(.system(size: 60))
            }.position(x: geo.size.width/2, y: geo.size.height/2)
        }
    }
}

struct LockedLevelView_Previews: PreviewProvider {
    static var previews: some View {
        LockedLevelView()
    }
}
