//
//  MeuMapaPessoalView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI

struct MeuMapaPessoalView: View {
    
    // Variáveis de exemplo para a tela
    @State private var emocaoMaisRegistrada: String = "Cansado"
    @State private var totalRegistros: Int = 1
    @State private var sequenciaAtual: Int = 0
    
    // Dados de exemplo para as tags
    let tagsPrincipais = ["#estudo", "#trabalho", "#familia", "#saúde"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Seção "Suas Emoções (Últimos 7 dias)"
                VStack(alignment: .leading, spacing: 10) {
                    Text("Suas Emoções (Últimos 7 dias)")
                        .font(.headline)
                    
                    HStack {
                        // Card de emoção (exemplo)
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .frame(height: 80)
                            .overlay(
                                HStack {
                                    Text("🥱")
                                        .font(.largeTitle)
                                    VStack(alignment: .leading) {
                                        Text("Cansado")
                                            .fontWeight(.bold)
                                        Text("1 vez (100.0%)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Rectangle()
                                        .fill(Color.purple)
                                        .frame(width: 80, height: 10)
                                        .cornerRadius(5)
                                }
                                .padding()
                            )
                    }
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                
                // Seção "Seus Contextos Principais"
                VStack(alignment: .leading, spacing: 10) {
                    Text("Seus Contextos Principais")
                        .font(.headline)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                        ForEach(tagsPrincipais, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.green)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                
                // Seção "Sua Jornada Emocional"
                VStack(alignment: .leading, spacing: 10) {
                    Text("Sua Jornada Emocional")
                        .font(.headline)
                    
                    HStack(spacing: 15) {
                        VStack(alignment: .center) {
                            Text("\(totalRegistros)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Total de Registros")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        
                        VStack(alignment: .center) {
                            Text("\(sequenciaAtual)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Sequência Atual")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        
                        VStack(alignment: .center) {
                            Text("2.0/5")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Humor Médio\nMais Comum: \(emocaoMaisRegistrada)")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                
            }
            .padding()
        }
        .background(Color(.systemGray5))
    }
}

// Preview para o Xcode
struct MeuMapaPessoalView_Previews: PreviewProvider {
    static var previews: some View {
        MeuMapaPessoalView()
    }
}
