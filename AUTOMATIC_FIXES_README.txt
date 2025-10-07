
Ações realizadas automaticamente:
- Removido o arquivo duplicate Emocao.swift (moved to Emocao.swift.bak) para evitar definição duplicada do tipo Emocao.
  O app já possui um Emocao struct em Estruturas.swift (com id: UUID, nome, porcentagem, usuarios, emoji).
  Mantive a versão de Estruturas.swift como fonte de verdade.

Sugestões manuais / otimizações recomendadas (aplicar manualmente nas views indicadas):

1) @Query sort syntax
   - Em SugestoesComunidadeView.swift troque:
       @Query(sort: \Dica.curtidas, order: .reverse) var todasAsDicas: [Dica]
     Por:
       @Query(sort: \.curtidas, order: .reverse) var todasAsDicas: [Dica]

   Observação: SwiftData aceita a key-path \.property (ex: \.curtidas). Ajuste se o compilador indicar outra forma.

2) MeuMapaPessoalView - Uso de @Query com inicializador customizado
   - Se você precisa criar um FetchDescriptor customizado no init, use:
       @Query private var meusRegistros: [RegistroDiario]
       init() {
           let descriptor = FetchDescriptor<RegistroDiario>(predicate: .init(#"userId == $0"#))
           _meusRegistros = Query(descriptor)
       }
     Ou, se quiser filtrar pelo usuário logado via modelContext, prefira buscar via função que use context.fetch(...).

   - Verifique se RegistroDiario.userId é String (conforme Estruturas.swift) e se você está usando o mesmo campo ao filtrar.

3) Consistência de tipos Emocao
   - Remova ou ajuste referências que esperam 'Emocao' com campos diferentes (como id: String). Agora Emocao tem id: UUID e campos (nome, porcentagem, usuarios, emoji).
   - Atualize código que cria Emocao(nome:..., ...) para usar UUID() ou simplesmente use Emocao(id: UUID(), nome: "...", ...).

4) Save / increment de curtidas
   - Ao modificar uma instância @Model, ex:
       dica.curtidas += 1
       try? context.save()
     Isso está ok, mas prefira usar do/try/catch e tratar erros.

5) ModelContainer
   - Em SentirFlowApp.modelContainer(for: [RegistroDiario.self, Dica.self]) está correto. Se você criar novas @Model classes, adicione aqui.

6) Previews
   - Para previews que usam SwiftData, adapte para fornecer um ModelContainer temporário:
       @Environment(\.modelContext) private var modelContext
       // e em preview:
       .modelContainer(for: [Dica.self, RegistroDiario.self])

Sugestão final:
- Tente compilar após remover o arquivo duplicado. Se aparecerem erros, cole aqui o log de build — eu posso ajustar o código linha-a-linha.
