//
//  Pokedex3_0App.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

@main
struct Pokedex3_0App: App {
    
    // create and add it to the managed object environment
    // if u add and environment into ur contentView,
    // u will be able to access it thru out all of ur other Views
    let persistenceController = PersistenceController.shared

    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            PokedexView()
                // injected persistencController as environment
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        // listen on change of scenePhase
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
                
            case .background:
                print("Scene is in background")
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Apple must have changed something...")
            }
        }
    }
}
