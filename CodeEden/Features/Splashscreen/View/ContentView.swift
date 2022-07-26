//
//  ContentView.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 22/07/22.
//

import SwiftUI
import CoreData

//navigationBarBackButton.hidden = true

struct ContentView: View {
    
    @AppStorage("userStatus") var status: Bool = false
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Player.timestamp, ascending: true)],
            animation: .default)
        private var items: FetchedResults<Player>
        
    @State var animate = false
    @State var dissolve = false
    @State var tap = false
    
    var body: some View
    {
        ZStack
        {
            
            if status
            {
//                if !items.isEmpty
//                {
//                    MainView(player: .constant(items.first))
//                }
                
                Level1()
                
            }
            
            else
            {
                OnboardingViewFirst()
            }
            
            ZStack
            {
                
                Image("iPhone Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            
                    GeometryReader
                    {
                        geometry in
                        
                        VStack
                        {
                            Image("Code Eden Logo ").resizable().frame(width: geometry.size.width, height: geometry.size.height * 0.25).scaleEffect(animate ? 3:1)
                            
                            Text("Tap to continue...").font(Font.custom("Silom", size: geometry.size.width * 0.04)).foregroundColor(Color("whiteAccent")).opacity(tap ? 0.5:1).onAppear(perform: tapAnimate).onTapGesture(perform: animateSplash)
                        }.position(x: geometry.size.width/2, y: geometry.size.height/2)
                    
                    }
               
            }.opacity(dissolve ? 0:1)
           
        }
    }
    
    func tapAnimate()
    {
        DispatchQueue.main.async {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                tap.toggle()
            }
        }
    }
    
    func animateSplash()
    {
        DispatchQueue.main.async {
            
            withAnimation (Animation.easeOut(duration: 0.45)) {
                animate.toggle()
            }
            
            withAnimation (Animation.easeOut(duration: 0.35)) {
                dissolve.toggle()
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 13")
        
    }
}
