//
//  SentirFlowApp.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

import SwiftUI

@main
struct SentirFlowApp: App {
    // Instância do AppData para ser compartilhada
    @StateObject var appData = AppData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
