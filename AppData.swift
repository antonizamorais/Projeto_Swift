//
//  AppData.swift
//  SentirFlow
//
//  Created by user on 30/09/25.
//


import Foundation
import SwiftUI

// NOTA: Assumimos que as structs 'Emocao' e 'Dica' estão definidas em um arquivo separado (ex: Modelos.swift)

// Struct para um registro completo do diário (mantém apenas o que é exclusivo do AppData)
struct RegistroDiario: Identifiable {
    let id = UUID()
    let userId: String
    let emocao: Emocao
    let texto: String
    let tags: [String]
    let data: Date
}

class AppData: ObservableObject {
    
    // Variável que SIMULA o usuário logado
    let usuarioLogadoId: String = "user123_niza"
    
    // MARK: - Dados de Armazenamento
    
    @Published var registrosDiarios: [RegistroDiario] = []
    @Published var dicasComunidade: [Dica] = [
        // Dados iniciais de exemplo (com curtidas)
        Dica(texto: "Tirou uma soneca", autor: "Comunidade", curtidas: 188),
        Dica(texto: "Compartilhou gratidão", autor: "Comunidade", curtidas: 169),
        Dica(texto: "Conversou com alguém", autor: "Comunidade", curtidas: 178),
        Dica(texto: "Caminhou 30 minutos", autor: "Comunidade", curtidas: 167),
        Dica(texto: "Criou algo com as mãos", autor: "Comunidade", curtidas: 190)
    ]
    
    // MARK: - Funções de Escrita (Salvar)
    
    // Salva um novo registro do diário
    func salvarRegistro(emocao: Emocao, texto: String, tags: [String]) {
        let novoRegistro = RegistroDiario(
            userId: usuarioLogadoId,
            emocao: emocao,
            texto: texto,
            tags: tags,
            data: Date()
        )
        registrosDiarios.append(novoRegistro)
    }
    
    // Salva uma nova dica da comunidade
    func salvarDica(emocao: Emocao, texto: String) {
        let novaDica = Dica(texto: texto, autor: "Usuário Anônimo", curtidas: 1)
        dicasComunidade.append(novaDica)
    }
    
    // MARK: - Propriedades Calculadas para Visualização
    
    // 1. DADOS PESSOAIS (usados em MeuMapaPessoalView)
    
    // Filtra os registros para mostrar APENAS os do usuário logado
    func buscarMeusRegistros() -> [RegistroDiario] {
        return registrosDiarios.filter { $0.userId == usuarioLogadoId }
    }
    
    // 2. DADOS DA COMUNIDADE (usados em MapaSocialView)
    
    // Calcula as emoções mais comuns na comunidade (VAR - Resolvendo erro de compilação)
    var emocoesComunidade: [Emocao] {
        guard !registrosDiarios.isEmpty else { return [] }
        
        let totalRegistros = Double(registrosDiarios.count)
        var contagemEmocoes: [String: (Emocao, Int)] = [:]
        
        // Agrega a contagem
        for registro in registrosDiarios {
            let nome = registro.emocao.nome
            contagemEmocoes[nome, default: (registro.emocao, 0)].1 += 1
        }
        
        // Transforma em lista de Emocao
        let emocoesAgregadas = contagemEmocoes.map { (_, valor) -> Emocao in
            let (emocaoOriginal, contagem) = valor
            let porcentagem = Int((Double(contagem) / totalRegistros) * 100)
            
            return Emocao(
                nome: emocaoOriginal.nome,
                porcentagem: porcentagem,
                usuarios: contagem,
                emoji: emocaoOriginal.emoji
            )
        }
        
        return emocoesAgregadas.sorted { $0.porcentagem > $1.porcentagem }
    }
    
    // Busca as 5 dicas mais curtidas da comunidade (VAR - Resolvendo erro de compilação)
    var dicasMaisPopulares: [Dica] {
        return dicasComunidade
            .sorted { $0.curtidas > $1.curtidas }
            .prefix(5)
            .map { $0 }
    }
    
    // Filtra as dicas da comunidade por uma emoção específica (usada em SugestoesComunidadeView)
    func buscarDicasPorEmocao(_ emocao: String) -> [Dica] {
        // Por enquanto, retorna todas as dicas, pois a struct Dica não tem o campo de emoção
        return dicasComunidade
    }
}
