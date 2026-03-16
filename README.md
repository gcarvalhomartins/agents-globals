# Agent Global (agb)

Gerenciador de skills para o OpenCode. Permite instalar, atualizar e compartilhar skills customizadas para usar com o assistente de IA.

## Requisitos

- Bash (Linux/macOS) ou PowerShell (Windows)
- Git
- Permissão de administrador (para instalação global)

## Instalação

### Linux / macOS

1. Clone o repositório:
```bash
git clone git@github.com:gcarvalhomartins/agents-globals.git
cd agents-globals
```

2. Execute o instalador:
```bash
chmod +x install.sh
./install.sh
```

3. O script será instalado em `/usr/local/bin/agb` e você poderá usar o comando `agb` de qualquer lugar.

### Windows

1. Clone o repositório:
```bash
git clone git@github.com:gcarvalhomartins/agents-globals.git
cd agents-globals
```

2. Execute o instalador no PowerShell:
```powershell
.\windows-install.ps1
```

## Uso

Após a instalação, use o comando `agb` no terminal:

```bash
agb              # Abre o menu interativo
agb --help       # Mostra a ajuda
agb --sync       # Sincroniza skills diretamente
agb --pr         # Cria um Pull Request
```

### Menu Interativo

Ao executar `agb` sem argumentos, você verá um menu com as seguintes opções:

- **Instalar / Atualizar Skills**: Baixa as skills disponíveis no repositório e permite selecionar quais deseja instalar
- **Compartilhar uma Skill (Criar PR)**: Envia uma skill local para o repositório remoto via Pull Request

### Comandos

| Comando | Descrição |
|---------|------------|
| `agb` | Menu interativo |
| `agb -s`, `agb --sync` | Baixa e sincroniza as skills |
| `agb -p`, `agb --pr` | Interface de Pull Request |
| `agb -h`, `agb --help` | Ajuda |

## Skills Disponíveis

- **napkin**: Mantém contexto do projeto e decisões arquiteturais
- **interface-design**: Criação de interfaces web e componentes
- **python-clean-code**: Práticas de código limpo em Python
- **playwright**: Testes E2E e automação de browser
- **skill-creator**: Criação e melhoria de skills

## Solução de Problemas

### Permission denied ao instalar

Execute o instalador com sudo:
```bash
sudo ./install.sh
```

### Git não configurado

Configure seu usuário e email do Git:
```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

## Licença

MIT
