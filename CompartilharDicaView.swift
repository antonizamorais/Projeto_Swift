//
//  CompartilharDicaView.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

import SwiftUI
import SwiftData

struct CompartilharDicaView: View {
    
    // Injeções de Ambiente
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss // Necessário para fechar o modal
    @Environment(\.modelContext) var modelContext
    
    // Variáveis de Estado
    @State private var selectedEmocao: Emocao? = nil
    @State private var suaDica: String = ""
    
    // Lista de emoções pré-definidas (para o Picker)
    let emocoesDisponiveis: [Emocao] = [
        Emocao(nome: "Ansiedade", porcentagem: 20, usuarios: 351, emoji: "😟"),
        Emocao(nome: "Tristeza", porcentagem: 10, usuarios: 122, emoji: "😔"),
        Emocao(nome: "Cansaço", porcentagem: 30, usuarios: 374, emoji: "😩"),
        Emocao(nome: "Felicidade", porcentagem: 35, usuarios: 489, emoji: "😊"),
        Emocao(nome: "Inspiração", porcentagem: 3, usuarios: 64, emoji: "✨"),
        Emocao(nome: "Produtividade", porcentagem: 15, usuarios: 187, emoji: "💪")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Seleção de Emoção
                    VStack(alignment: .leading) {
                        Text("Para qual emoção?")
                            .font(.headline)
                        
                        Picker("Selecione uma emoção...", selection: $selectedEmocao) {
                            Text("Selecione uma emoção...").tag(nil as Emocao?)
                            
                            ForEach(emocoesDisponiveis) { emocao in
                                Text("\(emocao.emoji) \(emocao.nome)").tag(emocao as Emocao?)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    
                    // MARK: - Campo da Dica
                    VStack(alignment: .leading) {
                        Text("Sua dica")
                            .font(.headline)
                        
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $suaDica)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)

                            if suaDica.isEmpty {
                                Text("Ex: Respiração 4-7-8, caminhada de 10min...")
                                    .foregroundColor(Color(.placeholderText))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                        }
                    }
                    
                    // MARK: - Botão de Envio
                    Button("Compartilhar Dica") {
                        salvarDica()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Compartilhe Suas Dicas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss() // Fecha o modal
                    }
                }
            }
        }
    }
    
    // MARK: - Lógica de Salvamento
    
    func salvarDica() {
        guard let emocao = selectedEmocao, !suaDica.isEmpty else {
            print("Aviso: Selecione uma emoção e digite uma dica válida.")
            return
        }
        
        // Chamada correta com ModelContext
        appData.salvarDica(
            context: modelContext,
            emocao: emocao,
            texto: suaDica
        )
        
        // Limpa o formulário e fecha o sheet
        selectedEmocao = nil
        suaDica = ""
        dismiss()
    }
}
