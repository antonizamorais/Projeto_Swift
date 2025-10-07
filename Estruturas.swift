//
//  Estruturas.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

// Arquivo Estruturas.swift

import Foundation
import SwiftData

// MARK: - Struct Emocao (Não é um @Model)
struct Emocao: Identifiable, Hashable, Equatable, Codable {
    // Todos os campos são let, mas o init garante que seja Codable.
    let id: UUID
    let nome: String
    let porcentagem: Int
    let usuarios: Int
    let emoji: String
    
    init(nome: String, porcentagem: Int, usuarios: Int, emoji: String) {
        self.id = UUID()
        self.nome = nome
        self.porcentagem = porcentagem
        self.usuarios = usuarios
        self.emoji = emoji
    }
}

// MARK: - Entidades SwiftData (@Model Classes)

@Model
final class RegistroDiario: Identifiable {
    var id: UUID
    var userId: String // CRÍTICO: Deve ser String para o filtro funcionar
    var emocao: Emocao // Emocao deve ser Codable
    var texto: String
    var tags: [String]
    var data: Date

    init(userId: String, emocao: Emocao, texto: String, tags: [String], data: Date) {
        self.id = UUID()
        self.userId = userId
        self.emocao = emocao
        self.texto = texto
        self.tags = tags
        self.data = data
    }
}

@Model
final class Dica: Identifiable {
    var id: UUID
    var texto: String
    var autor: String
    var curtidas: Int

    init(texto: String, autor: String, curtidas: Int) {
        self.id = UUID()
        self.texto = texto
        self.autor = autor
        self.curtidas = curtidas
    }
}
