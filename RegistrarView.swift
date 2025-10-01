//
//  RegistrarView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI

struct RegistrarView: View {
    
    // Variável de ambiente para acessar o AppData
    @EnvironmentObject var appData: AppData
    
    // Variáveis de estado para gerenciar a seleção e o texto do usuário
    @State private var selectedEmocao: String? = nil
    @State private var customEmocao: String = ""
    @State private var registroDiario: String = ""
    @State private var newTag: String = ""
    @State private var tags: [String] = ["#trabalho", "#familia", "#saúde", "#exercício", "#estudo", "#meditação"]
    
    // Lista de emoções pré-definidas (com os parâmetros que faltavam)
    let emocoes = [
        Emocao(nome: "Feliz", porcentagem: 0, usuarios: 0, emoji: "😊"),
        Emocao(nome: "Ansioso", porcentagem: 0, usuarios: 0, emoji: "😟"),
        Emocao(nome: "Cansado", porcentagem: 0, usuarios: 0, emoji: "🥱"),
        Emocao(nome: "Produtivo", porcentagem: 0, usuarios: 0, emoji: "🚀"),
        Emocao(nome: "Triste", porcentagem: 0, usuarios: 0, emoji: "😞"),
        Emocao(nome: "Inspirado", porcentagem: 0, usuarios: 0, emoji: "💡")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Título da tela
                Text("Como você está se sentindo hoje?")
                    .font(.title2)
                    .fontWeight(.bold)
                
                // Botões de emoções
                VStack(alignment: .leading, spacing: 15) {
                    Text("Escolha sua emoção principal:")
                        .font(.headline)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(emocoes, id: \.nome) { emocao in
                            Button(action: {
                                selectedEmocao = emocao.nome
                            }) {
                                VStack(spacing: 5) {
                                    Text(emocao.emoji)
                                        .font(.largeTitle)
                                    Text(emocao.nome)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                .background(selectedEmocao == emocao.nome ? Color.blue.opacity(0.2) : Color(.systemGray6))
                                .cornerRadius(10)
                                .foregroundColor(.primary)
                            }
                        }
                    }
                }
                
                // Campo de texto para o diário
                VStack(alignment: .leading, spacing: 10) {
                    Text("Conte-nos mais sobre o seu dia:")
                        .font(.headline)
                    
                    TextEditor(text: $registroDiario)
                        .frame(height: 150)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            Text("O que aconteceu hoje? Qual foi o ponto alto/baixo do seu dia?")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(12)
                                .opacity(registroDiario.isEmpty ? 1 : 0)
                        )
                }
                
                // Seção de tags
                VStack(alignment: .leading, spacing: 10) {
                    Text("Tags do dia:")
                        .font(.headline)
                    
                    // Exibição das tags existentes
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.purple)
                                .cornerRadius(15)
                        }
                    }
                    
                    // Campo para criar nova tag
                    HStack {
                        TextField("Criar nova tag...", text: $newTag)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        Button("Adicionar") {
                            if !newTag.isEmpty {
                                tags.append("#\(newTag)")
                                newTag = ""
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                // Botão de salvar
                Button("Salvar Registro") {
                // Lógica para salvar os dados no AppData
                    if let emocaoSelecionada = emocoes.first(where: { $0.nome == selectedEmocao }) {
                            appData.salvarRegistro(emocao: emocaoSelecionada, texto: registroDiario, tags: tags)
                                
                                // Opcional: fechar a tela após o registro
                                // presentationMode.wrappedValue.dismiss()
                        }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Diário Privado")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview para o Xcode
struct RegistrarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistrarView()
        }
    }
}
