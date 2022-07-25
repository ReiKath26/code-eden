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
    
    @State var animate = false
    @State var dissolve = false
    @State var tap = false
    
    var body: some View
    {
        ZStack
        {
            
            if status
            {
                MainView()
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
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Player.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Player>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { Player in
//                    NavigationLink {
//                        Text("Item at \(Player.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(Player.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Player(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
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
