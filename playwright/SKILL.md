---
name: playwright
description: Use esta skill para testes E2E, automação de browser, scraping, geração de testes, validação de UI com Playwright. Trigger quando o usuário mencionar testes, E2E, automação, Playwright, ou quiser validar comportamento de interface.
---

# Playwright — Testes E2E e Automação de Browser

## Setup Inicial

Antes de usar, certifique-se que o MCP Playwright está ativo na configuração.
Para instalar localmente:
```bash
npm init playwright@latest
```

## Estrutura Recomendada

```
tests/
  e2e/
    pages/          # Page Objects
    fixtures/       # Test fixtures
    specs/          # Test specs
playwright.config.ts
```

## Padrão Page Object Model

```typescript
// tests/e2e/pages/LoginPage.ts
import { Page, Locator } from '@playwright/test';

export class LoginPage {
  readonly emailInput: Locator;
  readonly passwordInput: Locator;
  readonly submitButton: Locator;

  constructor(private page: Page) {
    this.emailInput = page.getByLabel('Email');
    this.passwordInput = page.getByLabel('Senha');
    this.submitButton = page.getByRole('button', { name: 'Entrar' });
  }

  async login(email: string, password: string) {
    await this.emailInput.fill(email);
    await this.passwordInput.fill(password);
    await this.submitButton.click();
  }
}
```

## Escrevendo Testes

```typescript
import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';

test.describe('Autenticação', () => {
  test('should redirect to dashboard when credentials are valid', async ({ page }) => {
    const loginPage = new LoginPage(page);
    
    await page.goto('/login');
    await loginPage.login('user@example.com', 'password123');
    
    await expect(page).toHaveURL('/dashboard');
  });

  test('should show error when credentials are invalid', async ({ page }) => {
    const loginPage = new LoginPage(page);
    
    await page.goto('/login');
    await loginPage.login('wrong@email.com', 'wrongpass');
    
    await expect(page.getByRole('alert')).toBeVisible();
  });
});
```

## Comandos Úteis

```bash
npx playwright test              # Rodar todos os testes
npx playwright test --ui         # Modo visual interativo
npx playwright test --debug      # Modo debug
npx playwright codegen           # Gravar testes automaticamente
npx playwright show-report       # Ver relatório HTML
```

## Usando via MCP Playwright

O MCP Playwright permite controlar o browser diretamente. Use as ferramentas:
- `playwright_navigate` — navegar para URLs
- `playwright_click` — clicar em elementos
- `playwright_fill` — preencher inputs
- `playwright_screenshot` — capturar screenshots
- `playwright_evaluate` — executar JavaScript

## Boas Práticas

- Use `getByRole`, `getByLabel`, `getByText` em vez de seletores CSS frágeis
- Evite `page.waitForTimeout()` — prefira esperas baseadas em estado
- Escreva testes independentes entre si
- Use fixtures para dados de teste reutilizáveis
- Capture screenshots em falhas para debugging
