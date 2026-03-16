---
name: skill-creator
description: Use esta skill para criar novas skills, melhorar skills existentes, ou avaliar a performance de uma skill. Trigger quando o usuário pedir para criar uma skill, melhorar uma skill, ou quando identificar uma pattern recorrente que merece virar uma skill.
---

# Skill Creator — Criando e Melhorando Skills

## O que é uma Skill

Uma skill é um arquivo `SKILL.md` com frontmatter YAML que ensina o agente a executar tarefas especializadas com qualidade.

## Estrutura de uma Skill

```markdown
---
name: nome-da-skill
description: Descrição precisa de QUANDO usar esta skill. Inclua triggers explícitos e casos de uso. Mencione também quando NÃO usar.
---

# Título da Skill

## Contexto e Propósito
O que esta skill faz e por que ela existe.

## Fluxo de Trabalho
Passos ordenados para executar a tarefa.

## Padrões e Templates
Código de exemplo, templates, convenções.

## Checklist de Qualidade
- [ ] Item de verificação 1
- [ ] Item de verificação 2

## Erros Comuns a Evitar
- Não faça X porque Y
```

## Processo de Criação de Skills

### 1. Identificar a Necessidade
Pergunte:
- Qual tarefa esta skill resolve?
- Quando deve ser acionada? Quais são os triggers?
- Quais são os padrões de qualidade para esta tarefa?
- Quais são os erros mais comuns?

### 2. Escrever a Descrição
A descrição é o campo mais crítico — ela determina quando a skill será usada:

**Boa descrição:**
```
Use esta skill para criar componentes React com Tailwind CSS. 
Trigger quando o usuário pedir: componente, card, botão, form, 
layout, ou qualquer elemento de UI em React. Não use para Vue, 
Angular ou HTML puro.
```

**Descrição ruim:**
```
Skill para React.
```

### 3. Definir o Fluxo
Liste os passos em ordem. Seja específico sobre o que fazer em cada etapa.

### 4. Adicionar Templates
Inclua exemplos de código que servem como ponto de partida.

### 5. Checklist de Qualidade
O que deve ser verificado antes de considerar a tarefa concluída?

## Onde Salvar

- **Global** (disponível em todos os projetos): `~/.config/opencode/skills/[nome]/SKILL.md`
- **Local** (apenas no projeto atual): `.opencode/skills/[nome]/SKILL.md`

## Melhorando Skills Existentes

Para melhorar uma skill:
1. Leia a skill atual
2. Identifique o que está faltando ou incorreto
3. Teste a skill com casos de uso reais
4. Refine a descrição e os padrões
5. Adicione exemplos baseados em problemas reais encontrados

## Exemplos de Skills Úteis

- `api-integration` — padrões para integrar APIs REST
- `code-review` — checklist para revisar PRs
- `database-migrations` — convenções para criar migrations
- `error-handling` — padrões de tratamento de erros
- `git-workflow` — convenções de commits e branches
