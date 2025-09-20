//
//  EmocaoService.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

import Foundation

class EmocaoService: ObservableObject{
    @Published var emocoes: [Emocao] = []
    private let fileName = "emocoes.json"
    
    init() {
        carregarEmocoes()
    }
    
    private func getFileURL() -> URL {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(fileName)
    }
    
    func carregarEmocoes(){
        let url = getFileURL()
        
        if !FileManager.default.fileExists(atPath: url.path),
           let bundleURL = Bundle.main.url(forResource: "emocoes", withExtension: "json"){
            try? FileManager.default.copyItem(at: bundleURL, to: url)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Emocao].self, from: data)
            self.emocoes = decoded
        }catch{
            print("Erro ao carregar JSON: \(error)")
        }
    }
    
    func salvarEmocoes(){
        let url = getFileURL()
        do{
            let data = try JSONEncoder().encode(emocoes)
            try data.write(to: url)
        } catch{
            print("Erro ao salvar Json: \(error)")
        }
    }
    
    func adicionarEmocao(_ emocao:Emocao){
        emocoes.insert(emocao, at: 0)
        salvarEmocoes()
    }
}
