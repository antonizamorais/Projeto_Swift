//
//  AppData.swift
//  SentirFlow
//
//  Created by user on 30/09/25.
//

import Foundation
import SwiftData
import SwiftUI

class AppData: ObservableObject {
    
    // Variável que SIMULA o usuário logado (usada para filtros)
    let usuarioLogadoId: String = "user123_joao"
    
    // Inicializador
    init() {}
    
    // MARK: - Funções de Escrita (Salvar)
    
    func salvarRegistro(context: ModelContext, emocao: Emocao, texto: String, tags: [String]) {
        let novoRegistro = RegistroDiario(
            userId: usuarioLogadoId,
            emocao: emocao,
            texto: texto,
            tags: tags,
            data: Date()
        )
        context.insert(novoRegistro)
        // Tratamento de erro simplificado
        try? context.save()
    }
    
    func salvarDica(context: ModelContext, emocao: Emocao, texto: String) {
        let novaDica = Dica(texto: texto, autor: "Usuário Anônimo", curtidas: 1)
        context.insert(novaDica)
        try? context.save()
    }
    
    func curtirDica(context: ModelContext, dica: Dica) {
        // Modifica a instância @Model diretamente
        dica.curtidas += 1
        try? context.save()
    }

    // MARK: - Funções de Leitura (Consultas)
    
    // NOTA: A função buscarMeusRegistros foi removida.
    // A consulta agora é feita diretamente pelo @Query na MeuMapaPessoalView.

    func buscarDicasMaisPopulares(context: ModelContext) -> [Dica] {
        // CRÍTICO: 'var descriptor' para permitir a atribuição do fetchLimit
        var descriptor = FetchDescriptor<Dica>(
            sortBy: [SortDescriptor(\.curtidas, order: .reverse)]
        )
        // Limita a 5 resultados
        descriptor.fetchLimit = 5
        
        // Retorna o resultado ou um array vazio
        return (try? context.fetch(descriptor)) ?? []
    }
    
    // Propriedade Calculada para Visualização (Dados fixos de simulação)
    func calcularEmocoesComunidade(context: ModelContext) -> [Emocao] {
        // Em um app real, esta função agregaria dados de RegistroDiario.
        return [
            Emocao(nome: "Ansiedade", porcentagem: 20, usuarios: 351, emoji: "😟"),
            Emocao(nome: "Felicidade", porcentagem: 35, usuarios: 489, emoji: "😊"),
            Emocao(nome: "Cansaço", porcentagem: 30, usuarios: 374, emoji: "😩")
        ]
    }
    
    func buscarDicasPorEmocao(context: ModelContext, emocaoNome: String) -> [Dica] {
        // Simplificado: Retorna todas as dicas.
        let descriptor = FetchDescriptor<Dica>()
        return (try? context.fetch(descriptor)) ?? []
    }
}
