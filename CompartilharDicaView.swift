//
//  CompartilharDicaView.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

import SwiftUI

struct CompartilharDicaView: View {
    
    // Variável de ambiente para acessar o AppData
    @EnvironmentObject var appData: AppData
        
    // Variável para fechar a tela (sheet)
    @Environment(\.presentationMode) var presentationMode
    
    // Variáveis para armazenar a seleção do usuário
    @State private var selectedEmocao: String = "Selecione uma emoção..."
    @State private var customEmocao: String = ""
    @State private var suaDica: String = ""
    
    // Texto de exemplo para o campo de dica
    @State private var placeholderDica = "Ex: Respirar 4-7-8, caminhar por 10min, ouvir uma música, etc..."
    
    // Opções de emoção para o seletor
    let emocoes = ["Selecione uma emoção...", "Ansiedade", "Tristeza", "Cansaço", "Felicidade", "Inspiração", "Produtividade"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Para qual emoção?")
                    .font(.subheadline)
                
                // Seletor de emoções (Picker) com largura ajustada
                Picker("Selecione uma emoção...", selection: $selectedEmocao) {
                    ForEach(emocoes, id: \.self) { emocao in
                        Text(emocao)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                // Campo para digitar uma emoção customizada, visível se "Selecione uma emoção" for escolhido
                if selectedEmocao == "Selecione uma emoção..." {
                    Text("Outra emoção?")
                        .font(.subheadline)
                    
                    TextField("Digite sua emoção aqui...", text: $customEmocao)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                Text("Sua dica")
                    .font(.subheadline)
                
                // Campo de texto para a dica com cor e placeholder
                ZStack(alignment: .topLeading) {
                    if suaDica.isEmpty {
                        Text(placeholderDica)
                            .foregroundColor(Color(UIColor.placeholderText))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                    }
                    TextEditor(text: $suaDica)
                        .frame(height: 100)
                        .padding(4)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                // Botão de envio
                Button("Compartilhar Dica") {
                // Lógica para enviar a dica para o AppData
                    let emocaoFinal = selectedEmocao == "Selecione uma emoção..." ? customEmocao : selectedEmocao
                            
                    // Pssar a emoção final para a função salvarDica
                    // appData.salvarDica(emocao: emocaoFinal, texto: suaDica)
                            
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Compartilhe Suas Dicas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

// Preview para o Xcode
struct CompartilharDicaView_Previews: PreviewProvider {
    static var previews: some View {
        CompartilharDicaView()
    }
}

