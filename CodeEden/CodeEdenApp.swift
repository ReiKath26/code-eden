//
//  CodeEdenApp.swift
//  CodeEden
//
//  Created by Kathleen Febiola Susanto on 22/07/22.
//

import SwiftUI

@main
struct CodeEdenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
