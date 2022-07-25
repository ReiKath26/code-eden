//
//  CodeEdenApp.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 22/07/22.
//

import SwiftUI

@main
struct CodeEdenApp: App {
    
    @StateObject private var dataMockStore = DataMockStore()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, dataMockStore.container.viewContext)
               
        }
    }
}
