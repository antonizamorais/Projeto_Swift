//
//  MapaSocialView.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//
import SwiftUI

struct MapaSocialView: View {
    
    // Variável para controlar qual mapa está sendo exibido
    @State private var selectedTab: String = "Comunidade"
    
    // Variável para controlar se o sheet está visível ou não
    @State private var showingShareSheet = false
    
    // Dados de exemplo para as emoções
    let emocoesComunidade: [Emocao] = [
        Emocao(nome: "Ansiosa", porcentagem: 20, usuarios: 351, emoji: "😟"),
        Emocao(nome: "Feliz", porcentagem: 35, usuarios: 489, emoji: "😊"),
        Emocao(nome: "Cansada", porcentagem: 30, usuarios: 374, emoji: "🥱"),
        Emocao(nome: "Produtiva", porcentagem: 10, usuarios: 187, emoji: "🚀"),
        Emocao(nome: "Triste", porcentagem: 7, usuarios: 122, emoji: "😞"),
        Emocao(nome: "Inspirada", porcentagem: 3, usuarios: 64, emoji: "💡")
    ]
    
    // Dados de exemplo para as dicas
    let dicasPopulares: [Dica] = [
        Dica(texto: "Tirou uma soneca", autor: "Por João Justino", curtidas: 188),
        Dica(texto: "Compartilhou gratidão", autor: "Por Ana Justino", curtidas: 169),
        Dica(texto: "Conversou com alguém", autor: "Por Leo Justino", curtidas: 178),
        Dica(texto: "Caminhou 30 minutos", autor: "Por Maria Justino", curtidas: 167),
        Dica(texto: "Criou algo com as mãos", autor: "Por Pedro Justino", curtidas: 190)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Seção de Cabeçalho
                    VStack(spacing: 5) {
                        Text("Mapa de Emoções Social")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Descubra como a comunidade está se sentindo e compartilhe experiências.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Picker para alternar entre "Meu Mapa Pessoal" e "Mapa da Comunidade"
                    Picker("Selecione o Mapa", selection: $selectedTab) {
                        Text("Meu Mapa Pessoal").tag("Pessoal")
                        Text("Mapa da Comunidade").tag("Comunidade")
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    // Conteúdo dinâmico baseado na seleção do Picker
                    if selectedTab == "Comunidade" {
                        
                        // Cartões de Emoções com NavigationLink
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Como a Comunidade Está Hoje")
                                .font(.headline)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                                ForEach(emocoesComunidade) { emocao in
                                    NavigationLink(destination: SugestoesComunidadeView(emocao: emocao)) {
                                        EmocaoCardView(emocao: emocao)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)

                        // Seção "Compartilhe Suas Dicas"
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Compartilhe Suas Dicas")
                                .font(.headline)
                            
                            Button("Compartilhar Dica") {
                                showingShareSheet = true
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                        
                        // Dicas Mais Úteis da Semana
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Dicas Mais Úteis da Semana")
                                .font(.headline)
                            
                            ForEach(dicasPopulares) { dica in
                                DicaRowView(dica: dica)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                        
                    } else {
                        // Exibe a tela "Meu Mapa Pessoal"
                        MeuMapaPessoalView()
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGray5))
            .sheet(isPresented: $showingShareSheet) {
                CompartilharDicaView()
            }
        }
    }
}

// Struct para o layout de cada cartão de emoção
struct EmocaoCardView: View {
    let emocao: Emocao
    
    var body: some View {
        VStack(spacing: 5) {
            Text(emocao.emoji)
                .font(.largeTitle)
            Text(emocao.nome)
                .font(.subheadline)
                .fontWeight(.bold)
            Text("\(emocao.porcentagem)%")
                .font(.caption)
                .foregroundColor(.blue)
            Text("\(emocao.usuarios) pessoas")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .padding(5)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// Struct para o layout de cada dica
struct DicaRowView: View {
    let dica: Dica
    
    var body: some View {
        HStack {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(dica.texto)
                    .font(.subheadline)
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
        .padding(.vertical, 5)
    }
}
// Preview para o Xcode
struct MapaSocialView_Previews: PreviewProvider {
    static var previews: some View {
        MapaSocialView()
    }
}
