//
//  RegistrarView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI
import SwiftData // Necessário para ModelContext

struct RegistrarView: View {
    
    @EnvironmentObject var appData: AppData
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedEmocao: Emocao? = nil
    @State private var textoDiario: String = ""
    @State private var tagInput: String = ""
    
    let emocoesDisponiveis: [Emocao] = [
        Emocao(nome: "Feliz", porcentagem: 35, usuarios: 489, emoji: "😊"),
        Emocao(nome: "Ansioso", porcentagem: 20, usuarios: 351, emoji: "😟"),
        Emocao(nome: "Cansado", porcentagem: 30, usuarios: 374, emoji: "😩"),
        Emocao(nome: "Triste", porcentagem: 10, usuarios: 122, emoji: "😔"),
        Emocao(nome: "Grato", porcentagem: 5, usuarios: 88, emoji: "🙏"),
    ]
    
    var body: some View {
        // ... (Interface da View)
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // ... (Campos de Emocao, Texto e Tags)
                    
                    VStack(alignment: .leading) {
                        Text("Como você se sente hoje?")
                            .font(.headline)
                        
                        Picker("Selecione uma emoção...", selection: $selectedEmocao) {
                            Text("Selecione uma emoção...").tag(nil as Emocao?)
                            
                            ForEach(emocoesDisponiveis) { emocao in
                                // Emocao deve ser Hashable/Equatable
                                Text("\(emocao.emoji) \(emocao.nome)").tag(emocao as Emocao?)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Seus pensamentos")
                            .font(.headline)
                        
                        TextEditor(text: $textoDiario)
                            .frame(height: 150)
                            .padding(4)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        if textoDiario.isEmpty {
                            Text("Digite aqui o que aconteceu hoje...")
                                .foregroundColor(Color(.placeholderText))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Contexto (Tags)")
                            .font(.headline)
                        TextField("Ex: #trabalho, #família", text: $tagInput)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Spacer()
                    
                    // MARK: - Botão Salvar
                    Button("Salvar Registro") {
                        salvarRegistro()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
                }
                .padding()
            }
            .navigationTitle("Novo Registro")
        }
    }
    
    func salvarRegistro() {
        guard let emocao = selectedEmocao else {
            return
        }
        
        let tagsFinais = tagInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        
        // Chamada correta com ModelContext
        appData.salvarRegistro(
            context: modelContext,
            emocao: emocao,
            texto: textoDiario,
            tags: tagsFinais
        )
        
        selectedEmocao = nil
        textoDiario = ""
        tagInput = ""
    }
}
