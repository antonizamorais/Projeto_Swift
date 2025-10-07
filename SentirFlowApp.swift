//
//  SentirFlowApp.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

// Arquivo SentirFlowApp.swift

import SwiftUI
import SwiftData

@main
struct SentirFlowApp: App {
    
    @StateObject var appData = AppData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
        }
        // Configura o Contêiner de Modelos do SwiftData
        .modelContainer(for: [RegistroDiario.self, Dica.self])
    }
}
