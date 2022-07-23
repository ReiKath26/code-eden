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
                VStack
                {
                    Image("Code Eden Logo ").resizable().frame(width: 400, height: 200).scaleEffect(animate ? 3:1)
                    
                    Text("Tap anywhere to continue...").font(Font.custom("Silom", size:16)).foregroundColor(Color("whiteAccent"))
                }
               
            }.opacity(dissolve ? 0:1)
           
        }.onTapGesture(perform: animateSplash)
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
