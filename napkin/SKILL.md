---
name: napkin
description: Use esta skill para manter e consultar o contexto do projeto. Trigger SEMPRE antes de iniciar uma nova tarefa para verificar o estado do projeto, após completar tarefas importantes para registrar decisões, e quando o usuário mencionar contexto, memória do projeto, decisões, ou "o que já foi feito".
---

# Napkin — Contexto e Memória do Projeto

## O que é o Napkin

O Napkin é o "caderno de anotações" do projeto. Ele mantém o contexto entre sessões para que você nunca perca o fio da meada.

## Estrutura do Arquivo de Contexto

O contexto é salvo em `.opencode/context.md` na raiz do projeto:

```markdown
# Contexto do Projeto: [Nome]

## Visão Geral
[Descrição em 2-3 linhas do que é o projeto]

## Stack Técnica
- Frontend: 
- Backend:
- Banco de dados:
- Deploy:

## Decisões Arquiteturais
- [Data] — [Decisão tomada e motivo]

## Tarefas em Andamento
- [ ] [Tarefa atual]
- [ ] [Próxima tarefa]

## Tarefas Concluídas
- [x] [Tarefa concluída]

## Padrões e Convenções
- [Padrão de nomenclatura, estrutura de pastas, etc.]

## Dependências Importantes
- [Biblioteca/serviço e para que é usado]

## Problemas Conhecidos / Débitos Técnicos
- [Problema e status]

## Notas Importantes
- [Qualquer coisa que não deve ser esquecida]
```

## Como Usar

### Lendo o Contexto
Antes de qualquer tarefa:
```
Leia o arquivo .opencode/context.md para entender o estado atual do projeto.
Se não existir, crie-o com as informações básicas do projeto.
```

### Atualizando o Contexto
Após completar tarefas importantes:
```
Atualize .opencode/context.md:
- Marque tarefas concluídas
- Adicione novas tarefas identificadas
- Registre decisões técnicas tomadas
- Anote problemas encontrados
```

## Fluxo de Trabalho com Napkin

1. **Início de sessão** → Leia `.opencode/context.md`
2. **Durante trabalho** → Registre decisões importantes em tempo real
3. **Fim de tarefa** → Atualize status das tarefas
4. **Problema encontrado** → Adicione em "Problemas Conhecidos"
5. **Nova convenção** → Adicione em "Padrões e Convenções"

## Integração com Outros Agentes

Todos os agentes devem:
1. Ler o contexto no início
2. Operar respeitando as convenções registradas
3. Atualizar o contexto ao concluir

Isso garante consistência mesmo ao trocar de agente (`@designer`, `@tester`, etc.).
