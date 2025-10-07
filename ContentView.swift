//
//  ContentView.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

// Arquivo ContentView.swift

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appData: AppData
    
    @State private var selectedTab: String = "Mapa Social"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Aba 1: Mapa Social
            MapaSocialView()
                .tabItem {
                    Label("Mapa Social", systemImage: "map.circle.fill")
                }
                .tag("Mapa Social")
            
            // Aba 2: Registrar
            RegistrarView()
                .tabItem {
                    Label("Registrar", systemImage: "square.and.pencil.circle.fill")
                }
                .tag("Registrar")
            
            // Aba 3: Meu Mapa Pessoal (Meus Dados)
            MeuMapaPessoalView(appData: appData) // Passa o appData no init do Meus Dados
                .tabItem {
                    Label("Meus Dados", systemImage: "person.circle.fill")
                }
                .tag("Meus Dados")
            
            // Aba 4: Compartilhar Dica (Diário Colaborativo)
            // Usamos CompartilharDicaView, que funciona como um modal para o Diário Colaborativo
            Text("Diário Colaborativo: Use o botão 'Compartilhar' no Mapa Social") // Placeholder
                .tabItem {
                    Label("Diário Colab.", systemImage: "square.and.arrow.up.circle.fill")
                }
                .tag("Diário Colab.")
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    // Injeta o AppData para que as previews funcionem
    @StateObject static var mockAppData = AppData()
    
    static var previews: some View {
        ContentView()
            .environmentObject(mockAppData)
            // O contêiner de modelo é injetado no SentirFlowApp
    }
}
