//
//  SugestoesComunidadeView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI
import SwiftData

struct SugestoesComunidadeView: View {
    
    // 1. Recebe a Emoção clicada do MapaSocialView
    let emocaoSelecionada: Emocao
    
    // Injeções de Ambiente
    @EnvironmentObject var appData: AppData
    @Environment(\.modelContext) var modelContext // Contexto para buscar dicas e curtir
    @Environment(\.dismiss) var dismiss // Para fechar a tela (se for um sheet ou modal)
    
    // 2. Query para buscar todas as Dicas (e depois filtrar)
    @Query(sort: \Dica.curtidas, order: .reverse) var todasAsDicas: [Dica]

    // 3. Propriedade Calculada: Filtra as dicas que se aplicam à emoção
    var dicasFiltradas: [Dica] {
        // NOTA: Para um filtro por emoção real, a struct Dica precisaria ter um campo 'emocao'
        // Por enquanto, retornamos as 10 mais populares para simular a sugestão.
        return todasAsDicas
            .filter { _ in true } // Filtro placeholder. Altere para uma lógica de filtragem real
            .prefix(10) // 10 dicas mais curtidas
            .map { $0 }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // MARK: - Cabeçalho da Emoção Selecionada
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(emocaoSelecionada.emoji) \(emocaoSelecionada.nome) - \(emocaoSelecionada.porcentagem)% da comunidade")
                            .font(.title2.bold())
                        
                        Text("Sugestões da Comunidade")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // MARK: - Contextos Mais Comuns
                    VStack(alignment: .leading) {
                        Text("Contextos Mais Comuns")
                            .font(.headline)
                        
                        // NOTA: Esta lógica exigiria que você agregasse as tags dos RegistroDiario.
                        // Usaremos tags fixas como placeholder por enquanto.
                        HStack {
                            TagView(tag: "#trabalho")
                            TagView(tag: "#prazo")
                            TagView(tag: "#estudos")
                            TagView(tag: "#família")
                            TagView(tag: "#saúde")
                        }
                    }
                    .padding(.horizontal)

                    Divider()

                    // MARK: - Dicas da Comunidade
                    VStack(alignment: .leading) {
                        Text("Dicas da Comunidade")
                            .font(.headline)
                        
                        // Lista das Dicas Filtradas
                        ForEach(dicasFiltradas) { dica in
                            DicaSugestaoRow(dica: dica)
                                .environmentObject(appData) // Passa o AppData para a Dica
                                .environment(\.modelContext, modelContext) // Passa o contexto para a ação de curtir
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Sugestões")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Componentes Auxiliares

struct TagView: View {
    let tag: String
    var body: some View {
        Text(tag)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(.systemTeal).opacity(0.15))
            .cornerRadius(10)
    }
}

struct DicaSugestaoRow: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.modelContext) var modelContext
    
    let dica: Dica
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dica.texto)
                    .font(.body)
                Text("Por: \(dica.autor)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
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
            }
            .buttonStyle(.plain)
            
            Button("Vou Tentar") {
                // Ação para o botão "Vou Tentar"
                print("Usuário tentará a dica: \(dica.texto)")
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }
}

// MARK: - Preview

struct SugestoesComunidadeView_Previews: PreviewProvider {
    // Cria uma Emoção de exemplo para a preview
    static let mockEmocao = Emocao(nome: "Ansiedade", porcentagem: 35, usuarios: 489, emoji: "😟")
    @StateObject static var mockAppData = AppData()
    
    static var previews: some View {
        SugestoesComunidadeView(emocaoSelecionada: mockEmocao)
            .environmentObject(mockAppData)
    }
}
