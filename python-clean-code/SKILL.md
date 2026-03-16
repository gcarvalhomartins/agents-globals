---
name: python-clean-code
description: Use esta skill sempre que escrever, revisar, refatorar ou avaliar código Python. Trigger quando o usuário pedir para criar módulos, classes, funções, scripts, APIs, CLIs, ou qualquer código Python. Também ative ao revisar PRs, fazer code review, ou refatorar código existente em Python. Não use para outras linguagens.
---

# Python Clean Code — Código Limpo e Pythônico

## Princípios Fundamentais

Todo código Python gerado deve seguir, nesta ordem de prioridade:

1. **Legibilidade** — código é lido muito mais do que escrito
2. **Simplicidade** — prefira a solução mais simples que funciona (KISS)
3. **Explicitidade** — explícito é melhor que implícito (Zen of Python)
4. **Testabilidade** — escreva código que pode ser testado facilmente
5. **Pythonismo** — use os idiomas e convenções da linguagem

---

## Fluxo de Trabalho

Antes de escrever qualquer código:

1. **Entenda o domínio** — o que esse código representa no mundo real?
2. **Nomeie bem** — escolha nomes antes de escrever a lógica
3. **Escreva a assinatura** — defina tipos de entrada e saída
4. **Implemente** — uma responsabilidade por função/classe
5. **Revise** — aplique o checklist ao final

---

## Convenções de Nomenclatura

```python
# Variáveis e funções: snake_case
user_name = "Alice"
total_price = 0.0

def calculate_discount(price: float, rate: float) -> float:
    ...

# Classes: PascalCase
class OrderProcessor:
    ...

# Constantes: UPPER_SNAKE_CASE
MAX_RETRIES = 3
DEFAULT_TIMEOUT = 30.0

# Privados: prefixo _
class BankAccount:
    def __init__(self, balance: float) -> None:
        self._balance = balance  # interno à classe

    def _validate_amount(self, amount: float) -> None:  # método interno
        ...

# Evite abreviações obscuras
# ❌ calc_ttl_prc(p, r)
# ✅ calculate_total_price(price, rate)
```

---

## Type Hints — Sempre

```python
from typing import Optional, List, Dict, Tuple
from collections.abc import Sequence, Mapping

# ✅ Sempre anote tipos
def get_user(user_id: int) -> Optional[dict]:
    ...

def process_items(items: list[str]) -> list[str]:
    ...

# ✅ Use dataclasses para estruturas de dados
from dataclasses import dataclass, field

@dataclass
class Product:
    name: str
    price: float
    tags: list[str] = field(default_factory=list)
    active: bool = True

# ✅ TypeAlias para tipos complexos
UserId = int
PriceMap = dict[str, float]
```

---

## Funções Limpas

```python
# Regras:
# - Máximo ~20 linhas por função
# - Uma única responsabilidade
# - Sem efeitos colaterais inesperados
# - Parâmetros com nomes descritivos
# - Retorne cedo para evitar aninhamento

# ❌ Função com múltiplas responsabilidades
def process_order(order):
    # valida, calcula, salva, envia email — tudo junto
    ...

# ✅ Funções com responsabilidade única
def validate_order(order: Order) -> None:
    if not order.items:
        raise ValueError("Order must have at least one item")

def calculate_order_total(order: Order) -> float:
    return sum(item.price * item.quantity for item in order.items)

def save_order(order: Order, repository: OrderRepository) -> None:
    repository.save(order)

# ✅ Retorno antecipado (guard clauses)
def apply_discount(price: float, discount: float) -> float:
    if price <= 0:
        return 0.0
    if discount <= 0:
        return price
    return price * (1 - discount)
```

---

## Classes Limpas

```python
# ✅ Single Responsibility — uma classe, um motivo para mudar
class EmailSender:
    def __init__(self, smtp_host: str, port: int) -> None:
        self._smtp_host = smtp_host
        self._port = port

    def send(self, to: str, subject: str, body: str) -> None:
        ...

# ✅ Prefira composição a herança profunda
class OrderService:
    def __init__(
        self,
        repository: OrderRepository,
        email_sender: EmailSender,
        payment_gateway: PaymentGateway,
    ) -> None:
        self._repository = repository
        self._email_sender = email_sender
        self._payment_gateway = payment_gateway

# ✅ Use __slots__ em classes pequenas e intensivas
@dataclass
class Point:
    __slots__ = ("x", "y")
    x: float
    y: float
```

---

## Tratamento de Erros

```python
# ✅ Crie exceções de domínio específicas
class InsufficientFundsError(Exception):
    def __init__(self, balance: float, amount: float) -> None:
        self.balance = balance
        self.amount = amount
        super().__init__(
            f"Cannot withdraw {amount:.2f}. Balance is {balance:.2f}"
        )

# ✅ Capture exceções específicas, nunca Exception pura
try:
    result = process_payment(order)
except InsufficientFundsError as e:
    logger.warning("Payment failed: %s", e)
    raise
except httpx.TimeoutException:
    logger.error("Payment gateway timeout")
    raise PaymentGatewayError("Gateway unavailable") from None

# ❌ Nunca silencie erros
try:
    do_something()
except Exception:
    pass  # NUNCA faça isso
```

---

## Idiomas Pythônicos

```python
# ✅ List/dict/set comprehensions (mas não abuse)
active_users = [u for u in users if u.is_active]
prices = {product.id: product.price for product in catalog}

# ✅ Generator expressions para grandes volumes
total = sum(item.price for item in order.items)

# ✅ Unpacking
first, *rest = items
x, y = point
name, age = "Alice", 30

# ✅ Walrus operator para evitar repetição
if (n := len(data)) > 10:
    print(f"Too many items: {n}")

# ✅ Context managers para recursos
with open(filepath, encoding="utf-8") as f:
    content = f.read()

# ✅ enumerate em vez de range(len(...))
for index, item in enumerate(items, start=1):
    print(f"{index}. {item}")

# ✅ zip para iterar em paralelo
for name, score in zip(names, scores):
    print(f"{name}: {score}")

# ❌ Evite
if value == True:  # use: if value:
if value == None:  # use: if value is None:
```

---

## Imports

```python
# Ordem: stdlib → third-party → local
# Separados por linha em branco

import os
import sys
from pathlib import Path
from typing import Optional

import httpx
import pydantic

from myapp.core import settings
from myapp.models import User

# ✅ Imports absolutos sempre
# ❌ from ..utils import helper  # relativo — evite
# ✅ from myapp.utils import helper
```

---

## Docstrings

```python
def calculate_compound_interest(
    principal: float,
    rate: float,
    periods: int,
) -> float:
    """Calcula juros compostos.

    Args:
        principal: Valor inicial do investimento.
        rate: Taxa de juros por período (ex: 0.05 para 5%).
        periods: Número de períodos de capitalização.

    Returns:
        Valor final após aplicação dos juros.

    Raises:
        ValueError: Se principal ou periods forem negativos.

    Example:
        >>> calculate_compound_interest(1000, 0.05, 12)
        1795.8563...
    """
    if principal < 0 or periods < 0:
        raise ValueError("principal and periods must be non-negative")
    return principal * (1 + rate) ** periods
```

---

## Estrutura de Módulo

```
myproject/
├── pyproject.toml
├── README.md
├── src/
│   └── myproject/
│       ├── __init__.py
│       ├── core/
│       │   ├── __init__.py
│       │   └── settings.py
│       ├── domain/
│       │   ├── __init__.py
│       │   ├── models.py
│       │   └── exceptions.py
│       ├── services/
│       │   ├── __init__.py
│       │   └── order_service.py
│       └── repositories/
│           ├── __init__.py
│           └── order_repository.py
└── tests/
    ├── conftest.py
    ├── unit/
    └── integration/
```

---

## Checklist de Qualidade

Antes de considerar o código pronto, verifique:

- [ ] Todos os parâmetros e retornos têm type hints
- [ ] Nenhuma função tem mais de ~20 linhas
- [ ] Nenhuma função faz mais de uma coisa
- [ ] Variáveis têm nomes descritivos (sem abreviações obscuras)
- [ ] Nenhum `except Exception: pass`
- [ ] Imports organizados (stdlib → third-party → local)
- [ ] Docstring nas funções/classes públicas
- [ ] Sem código comentado ou `print()` de debug
- [ ] Sem magic numbers — use constantes nomeadas
- [ ] Código é testável (dependências injetáveis)

---

## Ferramentas de Qualidade

Configure no projeto:

```toml
# pyproject.toml
[tool.ruff]
line-length = 88
select = ["E", "F", "I", "N", "UP", "B", "SIM"]

[tool.mypy]
strict = true
python_version = "3.12"

[tool.pytest.ini_options]
testpaths = ["tests"]
```

```bash
# Verificar antes de commitar
ruff check .          # linting
mypy src/             # type checking
pytest --cov=src/     # testes com cobertura
```
