//
//  MeuMapaPessoalView.swift
//  SentirFlow
//
//  Created by user on 23/09/25.
//

import SwiftUI
import SwiftData

struct MeuMapaPessoalView: View {
    
    // Injeções de Ambiente
    @EnvironmentObject var appData: AppData
    @Environment(\.modelContext) var modelContext
    
    // Query que será preenchida pelo init customizado
    @Query private var meusRegistros: [RegistroDiario]
    
    // Construtor vazio padrão, necessário quando se usa o init customizado abaixo
    init() {
        // Inicializador vazio
    }
    
    // Inicializador customizado para construir a Query com filtro dinâmico
    init(appData: AppData) {
        // Usa o 'appData' passado para obter o ID antes do Predicate
        let userId = appData.usuarioLogadoId
        
        // Predicate do SwiftData para filtrar por usuário
        let predicate = #Predicate<RegistroDiario> { registro in
            registro.userId == userId
        }
        
        // Define a Query com o filtro e a ordem (mais recente primeiro)
        _meusRegistros = Query(
            filter: predicate,
            sort: [SortDescriptor(\.data, order: .reverse)]
        )
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if meusRegistros.isEmpty {
                    // ContentUnavailableView corrigida para evitar o erro 'No exact matches'
                    ContentUnavailableView(
                        "Nenhum Registro Encontrado",
                        systemImage: "person.crop.circle.badge.questionmark",
                        description: Text("Parece que você ainda não salvou nenhum registro. Vá para a aba 'Registrar' para começar.")
                    )
                } else {
                    List {
                        ForEach(meusRegistros) { registro in
                            RegistroDiarioRow(registro: registro)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Meu Mapa Pessoal")
        }
    }
}

// MARK: - Componente Auxiliar (RegistroDiarioRow)

struct RegistroDiarioRow: View {
    let registro: RegistroDiario
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(registro.emocao.emoji)
                    .font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text(registro.emocao.nome)
                        .font(.headline)
                    // Usa o dateFormatter estático
                    Text(registro.data, formatter: RegistroDiarioRow.dateFormatter)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(registro.texto)
                .font(.body)
                .lineLimit(2)
            
            if !registro.tags.isEmpty {
                HStack(spacing: 4) {
                    ForEach(registro.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}
