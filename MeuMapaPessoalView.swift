//
//  MeuMapaPessoalView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI

struct MeuMapaPessoalView: View {
    
    // 1. Injeta o objeto AppData para acessar os registros
    @EnvironmentObject var appData: AppData
    
    // Propriedade calculada: Filtra apenas os registros do usuário logado
    var meusRegistros: [RegistroDiario] {
        return appData.buscarMeusRegistros()
    }
    
    // Propriedade calculada: Total de registros
    var totalRegistros: Int {
        return meusRegistros.count
    }
    
    // Propriedade calculada: Analisa e retorna a emoção mais comum
    var insightsEmocionais: (maisComum: Emocao?, contagem: Int, porcentagem: Double) {
        let contagemEmocoes = meusRegistros.reduce(into: [String: (Emocao, Int)]()) { result, registro in
            let emocaoNome = registro.emocao.nome
            result[emocaoNome, default: (registro.emocao, 0)].1 += 1
        }
        
        guard let (_, (emocao, contagem)) = contagemEmocoes.max(by: { $0.value.1 < $1.value.1 }) else {
            return (nil, 0, 0.0) // Retorna zero se não houver registros
        }
        
        let porcentagem = totalRegistros > 0 ? (Double(contagem) / Double(totalRegistros)) * 100 : 0.0
        
        return (emocao, contagem, porcentagem)
    }

    // Propriedade calculada: Retorna as 5 tags mais comuns (por contagem)
    var tagsPrincipais: [String] {
        let contagemTags = meusRegistros.flatMap { $0.tags }.reduce(into: [String: Int]()) { result, tag in
            result[tag, default: 0] += 1
        }
        
        // Retorna as 5 tags mais comuns
        return contagemTags.sorted(by: { $0.value > $1.value }).prefix(5).map { $0.key }
    }
    
    // Propriedade calculada: Simulação simplificada da Sequência Atual (Streak)
    var sequenciaAtual: Int {
        // Lógica simples: Se tem mais de 5 registros, simula 4 dias de sequência
        if totalRegistros >= 5 {
            return 4
        } else if totalRegistros > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                if totalRegistros == 0 {
                    // 2. Estado vazio: Exibido se o usuário não tiver registros
                    VStack(alignment: .center) {
                        Image(systemName: "pencil.circle")
                            .font(.largeTitle)
                            .padding()
                        Text("Seu Mapa Pessoal está vazio.")
                            .font(.title3)
                            .fontWeight(.medium)
                        Text("Registre suas emoções no Diário Privado para ver seus insights aqui!")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(50)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()

                } else {
                    
                    // 3. Estado com dados: Exibe as informações calculadas
                    
                    // Seção "Suas Emoções (Últimos 7 dias)"
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Suas Emoções (Últimos 7 dias)")
                            .font(.headline)
                        
                        // Exibe a emoção mais comum
                        if let emocao = insightsEmocionais.maisComum {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                                .frame(height: 80)
                                .overlay(
                                    HStack {
                                        Text(emocao.emoji)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading) {
                                            Text(emocao.nome)
                                                .fontWeight(.bold)
                                            Text("\(insightsEmocionais.contagem) vez (\(insightsEmocionais.porcentagem, specifier: "%.1f")%)")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        // Barra de progresso visual
                                        Rectangle()
                                            .fill(Color.purple)
                                            .frame(width: CGFloat(insightsEmocionais.porcentagem * 1.5), height: 10)
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
                            // Total de Registros (usando a propriedade calculada)
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
                            
                            // Sequência Atual (usando a propriedade calculada)
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
                            
                            // Humor Médio
                            VStack(alignment: .center) {
                                Text("-") // Traço, pois o cálculo de humor médio exige um valor numérico para cada emoção
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("Humor Médio\nMais Comum: \(insightsEmocionais.maisComum?.nome ?? "Nenhum")")
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
            }
            .padding()
        }
        .background(Color(.systemGray5))
    }
}
// Preview para o Xcode
struct MeuMapaPessoalView_Previews: PreviewProvider {
    
    // Instância de teste do AppData para o Preview
    @StateObject static var mockAppData = AppData()
    
    static var previews: some View {
        NavigationStack {
            MeuMapaPessoalView()
                // Injeta o AppData no Preview
                .environmentObject(mockAppData)
        }
    }
}
