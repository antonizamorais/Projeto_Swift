//
//  Estruturas.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import Foundation
import SwiftUI

// Struct para o modelo de dados das emoções
struct Emocao: Identifiable {
    // Definir o 'id' assim funciona perfeitamente para Identifiable no SwiftUI
    let id = UUID()
    
    let nome: String
    let porcentagem: Int
    let usuarios: Int
    let emoji: String
}

// Struct para o modelo de dados das dicas
struct Dica: Identifiable {
    // Definir o 'id' assim funciona perfeitamente para Identifiable no SwiftUI
    let id = UUID()
    
    let texto: String
    let autor: String
    var curtidas: Int // Mantemos 'var' se você quiser incrementar as curtidas
}
