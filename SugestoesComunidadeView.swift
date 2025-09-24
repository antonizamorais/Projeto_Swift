//
//  SugestoesComunidadeView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI

// Modelo de dados para as tags de contexto
struct Contexto: Identifiable {
    let id = UUID()
    let nome: String
}

struct SugestoesComunidadeView: View {
    
    // A emoção que será passada da tela anterior
    let emocao: Emocao
    
    // Dados de exemplo para as tags e dicas
    let contextos: [Contexto] = [
        Contexto(nome: "#trabalho"),
        Contexto(nome: "#prazo"),
        Contexto(nome: "#estudos"),
        Contexto(nome: "#familia"),
        Contexto(nome: "#saude")
    ]
    
    let dicas: [Dica] = [
        Dica(texto: "Respiração 4-7-8", autor: "Por Anônimo", curtidas: 156),
        Dica(texto: "Caminhada de 10 minutos", autor: "Por Anônimo", curtidas: 134),
        Dica(texto: "Meditação guiada", autor: "Por Anônimo", curtidas: 98),
        Dica(texto: "Chá de camomila", autor: "Por Anônimo", curtidas: 87),
        Dica(texto: "Escrever 3 preocupações", autor: "Por Anônimo", curtidas: 76)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Título da tela com a emoção selecionada
                Text("\(emocao.emoji) \(emocao.nome) - \(emocao.porcentagem)% da comunidade")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Seção de Contextos Mais Comuns
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contextos Mais Comuns")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.leading)
                    
                    HStack {
                        ForEach(contextos) { contexto in
                            Text(contexto.nome)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.purple) // Cor dos tags
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Seção de Dicas da Comunidade
                VStack(alignment: .leading, spacing: 10) {
                    Text("Dicas da Comunidade")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.leading)
                    
                    ForEach(dicas) { dica in
                        DicaSugestaoRowView(dica: dica)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Sugestões da Comunidade")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Sub-view para o layout de cada dica na tela de sugestões
struct DicaSugestaoRowView: View {
    let dica: Dica
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(dica.texto)
                    .font(.headline)
                Text(dica.autor)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                Text("\(dica.curtidas)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
