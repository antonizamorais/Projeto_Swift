//
//  ContentView.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

import SwiftUI

// No seu arquivo ContentView.swift
struct ContentView: View {
    
    // Use @State para controlar qual aba está selecionada
    @State private var selectedTab = "Mapa Social"
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Aba 1: Mapa Social (agora é a tela inicial)
            MapaSocialView()
                .tabItem {
                    Label("Mapa Social", systemImage: "map.circle.fill")
                }
                .tag("Mapa Social") // Identificador único para a aba
            
            // Aba 2: Registrar
            RegistrarView()
                .tabItem {
                    Label("Registrar", systemImage: "square.and.pencil.circle.fill")
                }
                .tag("Registrar")
            
            // Aba 3: Meus Dados
            Text("Tela de Meus Dados")
                .tabItem {
                    Label("Meus Dados", systemImage: "person.circle.fill")
                }
                .tag("Meus Dados")
            
            // Aba 4: Compartilhar
            Text("Tela de Compartilhar")
                .tabItem {
                    Label("Compartilhar", systemImage: "square.and.arrow.up.circle.fill")
                }
                .tag("Compartilhar")
            
            // Aba 5: Colaborativo (corrigido)
            Text("Tela Colaborativa")
                .tabItem {
                    Label("Colaborativo", systemImage: "person.3.fill")
                }
                .tag("Colaborativo")
        }
    }
}

// Preview para o Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
