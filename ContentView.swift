//
//  ContentView.swift
//  SentirFlow
//
//  Created by user on 20/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var service = EmocaoService()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Mapa Social")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top, 10)
            
            ScrollView{
                VStack(spacing: 16){
                    ForEach(service.emocoes){ emocao in
                        HStack{
                            Text(emocao.emoji)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(emocao.titulo)
                                    .font(.headline)
                                Text(emocao.descricao)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
            }
            
            
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
