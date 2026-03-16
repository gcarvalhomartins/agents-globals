#!/bin/bash

echo -e "\033[1;36m==========================================================\033[0m"
echo -e "\033[1;32m      Instalador do Agent Global (agb) para OpenCode      \033[0m"
echo -e "\033[1;36m==========================================================\033[0m"

# Nome do arquivo principal do script
SCRIPT_NAME="agent_script.sh"
DEST_PATH="/usr/local/bin/agb"

# Verifica se o script principal está na mesma pasta
if [ ! -f "$SCRIPT_NAME" ]; then
    echo -e "❌ \033[1;31mErro: O arquivo '$SCRIPT_NAME' não foi encontrado nesta pasta.\033[0m"
    echo "Certifique-se de rodar este instalador no mesmo diretório do script principal."
    exit 1
fi

echo -e "\n⏳ Solicitando permissão de administrador para instalar em $DEST_PATH..."
# Copia o arquivo renomeando para 'agb' e dá permissão de execução
sudo cp "$SCRIPT_NAME" "$DEST_PATH"
sudo chmod +x "$DEST_PATH"

# Verifica se a instalação foi bem sucedida
if [ $? -eq 0 ]; then
    echo -e "\n✅ \033[1;32mInstalação concluída com sucesso!\033[0m"
    echo -e "Agora você pode usar o comando \033[1;33magb\033[0m de qualquer lugar no seu terminal.\n"
    echo "Experimente digitar:"
    echo "  agb         (para abrir o menu interativo)"
    echo "  agb --help  (para ver as opções de comando)"
else
    echo -e "\n❌ \033[1;31mFalha na instalação. Verifique sua senha e tente novamente.\033[0m"
fi
