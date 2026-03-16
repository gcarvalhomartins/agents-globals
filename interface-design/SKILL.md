---
name: interface-design
description: Use esta skill para criar interfaces web, componentes React/Vue/HTML, landing pages, dashboards, sistemas de design, ou qualquer trabalho de UI. Trigger quando o usuário pedir para criar, melhorar ou estilizar qualquer elemento visual de interface.
---

# Interface Design — Criação de UIs de Alta Qualidade

## Antes de Começar

1. Pergunte (se não informado): framework preferido, paleta de cores, tipografia, contexto do produto
2. Revise o design system existente no projeto
3. Comprometa-se com uma direção estética clara antes de codificar

## Direção Estética

Escolha UMA direção e execute com precisão:
- **Minimalismo refinado** — espaço negativo, tipografia precisa, zero decoração
- **Maximalismo expressivo** — layers, texturas, animações elaboradas
- **Brutalismo editorial** — contraste extremo, tipografia pesada, grids quebrados
- **Soft/Orgânico** — bordas arredondadas, gradientes suaves, paleta natural
- **Futurista/Tech** — dark mode, neon accents, glassmorphism
- **Retro/Vintage** — serifs clássicas, paleta terrosa, texturas de papel

**NUNCA use estética genérica de "AI design"**: gradientes roxos em fundo branco, Inter/Roboto, layouts previsíveis.

## Estrutura do Código

### React Component
```tsx
// Estrutura padrão para componentes
import { useState } from 'react';
import styles from './Component.module.css'; // ou Tailwind

interface ComponentProps {
  // props tipadas
}

export default function Component({ ...props }: ComponentProps) {
  return (
    <div className={styles.wrapper}>
      {/* conteúdo */}
    </div>
  );
}
```

### CSS Variables (Design Tokens)
```css
:root {
  /* Cores */
  --color-primary: #...;
  --color-surface: #...;
  --color-text: #...;
  
  /* Tipografia */
  --font-display: 'Nome', serif;
  --font-body: 'Nome', sans-serif;
  
  /* Espaçamento */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 32px;
  --space-xl: 64px;
  
  /* Raios */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 16px;
}
```

## Animações

Prefira CSS para animações simples:
```css
/* Entrada suave */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(8px); }
  to   { opacity: 1; transform: translateY(0); }
}

.element {
  animation: fadeIn 0.3s ease-out;
}
```

Para animações complexas em React, use `framer-motion`.

## Checklist de Qualidade

- [ ] Responsivo (mobile-first)
- [ ] Estados: default, hover, focus, disabled, loading, error
- [ ] Contraste WCAG AA (mínimo 4.5:1 para texto)
- [ ] Sem layout shift ao carregar
- [ ] Fontes com fallback adequado
- [ ] Dark mode considerado (mesmo que não implementado agora)

## Recursos de Fontes

Para fontes Google: `https://fonts.google.com`
Para fontes premium gratuitas: `https://fontsource.org`

Importação no CSS:
```css
@import url('https://fonts.googleapis.com/css2?family=NOME:wght@400;600;700&display=swap');
```
