//
//  Estruturas.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import Foundation

// Struct para o modelo de dados das emoções
struct Emocao: Identifiable, Decodable {
    let id = UUID()
    let nome: String
    let porcentagem: Int
    let usuarios: Int
    let emoji: String
}

// Struct para o modelo de dados das dicas
struct Dica: Identifiable, Decodable {
    let id = UUID()
    let texto: String
    let autor: String
    let curtidas: Int
}
