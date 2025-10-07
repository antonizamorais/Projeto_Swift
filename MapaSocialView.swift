//
//  MapaSocialView.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

import SwiftUI
import SwiftData

struct MapaSocialView: View {
    
    // Injeções de Ambiente
    @EnvironmentObject var appData: AppData
    @Environment(\.modelContext) var modelContext
    
    // Variáveis de Estado
    @State private var isSharingDica = false
    @State private var selectedEmocao: Emocao? = nil // Controla o sheet de sugestões
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // MARK: - Mapa de Emoções da Comunidade
                    VStack(alignment: .leading) {
                        HStack {
                            Text("A comunidade sente...")
                                .font(.title2.bold())
                            Spacer()
                            Button {
                                isSharingDica = true
                            } label: {
                                Label("Compartilhar", systemImage: "square.and.pencil")
                                    .font(.subheadline)
                            }
                        }

                        // A chamada para CommunityEmotionsGrid agora funciona
                        CommunityEmotionsGrid(
                            emocoes: appData.calcularEmocoesComunidade(context: modelContext),
                            selectedEmocao: $selectedEmocao
                        )
                    }
                    
                    Divider()
                    
                    // MARK: - Dicas Mais Populares
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Dicas Mais Populares")
                            .font(.title2.bold())

                        // Chamando a função diretamente para obter as dicas populares
                        let dicasPopulares = appData.buscarDicasMaisPopulares(context: modelContext)
                        
                        if dicasPopulares.isEmpty {
                            Text("Nenhuma dica compartilhada ainda.")
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(dicasPopulares) { dica in
                                DicaRow(dica: dica)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Mapa Social")
            .sheet(isPresented: $isSharingDica) {
                CompartilharDicaView()
            }
            // Abre o modal de Sugestões
            .sheet(item: $selectedEmocao) { emocao in
                SugestoesComunidadeView(emocaoSelecionada: emocao)
            }
        }
    }
}

// MARK: - Componente Auxiliar (CommunityEmotionsGrid)
// Trazido para este arquivo para resolver o erro de escopo

struct CommunityEmotionsGrid: View {
    let emocoes: [Emocao]
    @Binding var selectedEmocao: Emocao?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
            ForEach(emocoes, id: \.id) { emocao in
                VStack(alignment: .leading) {
                    Text("\(emocao.emoji) \(emocao.nome)")
                        .font(.headline)
                    
                    ProgressView(value: Double(emocao.porcentagem), total: 100)
                        .progressViewStyle(.linear)
                        .tint(Color.blue)
                    
                    Text("\(emocao.porcentagem)% da comunidade")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .onTapGesture {
                    selectedEmocao = emocao
                }
            }
        }
    }
}


// MARK: - Componente Auxiliar (DicaRow)
// Trazido para este arquivo para resolver o erro de escopo

struct DicaRow: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.modelContext) var modelContext
    
    let dica: Dica
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dica.texto)
                .font(.body)
            
            HStack {
                Text("Por: \(dica.autor)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // Botão de Curtir
                Button {
                    appData.curtirDica(context: modelContext, dica: dica)
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: dica.curtidas > 0 ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                        Text("\(dica.curtidas)")
                    }
                    .font(.subheadline)
                }
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview

struct MapaSocialView_Previews: PreviewProvider {
    @StateObject static var mockAppData = AppData()
    
    static var previews: some View {
        MapaSocialView()
            .environmentObject(mockAppData)
            // O contêiner de modelo deve ser injetado no SentirFlowApp
    }
}
