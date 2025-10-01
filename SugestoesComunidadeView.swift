//
//  SugestoesComunidadeView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI

struct SugestoesComunidadeView: View {
    
    @EnvironmentObject var appData: AppData
    
    // A emoção que será passada da tela anterior (MapaSocialView)
    let emocao: Emocao
    
    // Simula Contextos/Tags Mais Comuns
    // *NOTA*: Em um app real, essa seria uma função mais complexa no AppData
    // que buscaria as tags mais usadas nos registros dessa emoção.
    var contextosMaisComuns: [String] {
        if emocao.nome == "Ansioso" || emocao.nome == "Triste" {
            return ["#trabalho", "#prazo", "#família", "#estudos", "#saúde"]
        } else {
            return ["#exercício", "#natureza", "#amigos", "#meditação"]
        }
    }
    
    // Propriedade calculada para buscar as dicas específicas para esta emoção
    var dicasParaEmocao: [Dica] {
        // Usa a função do AppData para buscar dicas, ordenando pelas mais curtidas
        return appData.buscarDicasPorEmocao(emocao.nome)
            .sorted { $0.curtidas > $1.curtidas }
            .prefix(10) // Mostrar até 10 dicas
            .map { $0 }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                
                // Título e Porcentagem (Ex: Ansiedade - 35% da comunidade)
                VStack(alignment: .leading) {
                    Text("\(emocao.emoji) \(emocao.nome) - \(emocao.porcentagem)% da comunidade")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                
                // MARK: - Contextos Mais Comuns
                VStack(alignment: .leading, spacing: 10) {
                    Text("💡 Contextos Mais Comuns")
                        .font(.headline)
                        .foregroundColor(.green)
                    
                    // Exibe as tags em um layout simples
                    TagFlowLayout(tags: contextosMaisComuns)
                        .padding(.vertical, 5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                
                // MARK: - Dicas da Comunidade
                VStack(alignment: .leading, spacing: 15) {
                    Text("✨ Dicas da Comunidade")
                        .font(.headline)
                        .foregroundColor(.orange)
                    
                    if dicasParaEmocao.isEmpty {
                        Text("Ainda não há dicas para esta emoção. Seja o primeiro a compartilhar!")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(dicasParaEmocao) { dica in
                            DicaRowSocialView(dica: dica)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        .navigationTitle("Sugestões")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Componente para organizar as tags (simples)
struct TagFlowLayout: View {
    let tags: [String]
    
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(15)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Componente para exibir a dica (com likes e botão "Vou tentar")
struct DicaRowSocialView: View {
    let dica: Dica
    
    var body: some View {
        HStack {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
            
            VStack(alignment: .leading) {
                Text(dica.texto)
                    .font(.subheadline)
                Text("Por \(dica.autor)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Likes / Curtidas
            HStack(spacing: 4) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                Text("\(dica.curtidas)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
            
            // Botão "Vou tentar"
            Button("Vou tentar") {
                // Ação futura: Adicionar a dica a uma lista pessoal de "a tentar"
                print("Dica 'Vou tentar' clicada: \(dica.texto)")
            }
            .font(.caption)
            .padding(8)
            .background(Color.green.opacity(0.1))
            .foregroundColor(.green)
            .cornerRadius(8)
        }
        .padding(.vertical, 5)
    }
}

// MARK: - Preview

struct SugestoesComunidadeView_Previews: PreviewProvider {
    
    @StateObject static var mockAppData = AppData()
    
    // Emoção de exemplo para o Preview
    static let mockEmocao = Emocao(nome: "Ansioso", porcentagem: 35, usuarios: 489, emoji: "😟")
    
    static var previews: some View {
        NavigationStack {
            SugestoesComunidadeView(emocao: mockEmocao)
                .environmentObject(mockAppData)
        }
    }
}
