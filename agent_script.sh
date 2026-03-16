#!/bin/bash

# ==========================================
# 1. CONFIGURAÇÕES
# ==========================================
REPO_URL="git@github.com:gcarvalhomartins/agents-globals.git"
REPO_WEB_URL="https://github.com/gcarvalhomartins/agents-globals"
CACHE_DIR="$HOME/.config/opencode/.agents-globals-cache"
SKILLS_DIR="$HOME/.config/opencode/skills"

# Garante que a pasta base existe
mkdir -p "$SKILLS_DIR"

# ==========================================
# 2. FUNÇÕES
# ==========================================
show_banner() {
    clear
    echo -e "\033[1;36m==========================================================\033[0m"
    echo -e "\033[1;32m             W E L C O M E   A G E N T   G L O B A L      \033[0m"
    echo -e "\033[1;36m==========================================================\033[0m"
}

sync_repo() {
    if [ -d "$CACHE_DIR/.git" ]; then
        cd "$CACHE_DIR" || exit
        git checkout main -q
        git pull origin main -q
    else
        git clone -q "$REPO_URL" "$CACHE_DIR"
    fi
}

choose_skills_tui() {
    local options=("$@")
    local selected=()
    local cursor=0
    local window_start=0
    local window_size=10
    local total=${#options[@]}
    
    for i in "${!options[@]}"; do selected[i]=0; done

    tput civis # Oculta o cursor do terminal

    while true; do
        echo -en "\033[H\033[2J" # Limpa a tela
        show_banner
        echo -e "\033[1;33mInstalação de Skills\033[0m"
        echo -e "Use as \033[1;36mSetas ↑/↓\033[0m para navegar, \033[1;36mEspaço\033[0m para selecionar, \033[1;36mEnter\033[0m para confirmar.\n"

        local end=$((window_start + window_size))
        if [ $end -gt $total ]; then end=$total; fi

        for ((i=window_start; i<end; i++)); do
            local prefix="   "
            if [ $i -eq $cursor ]; then
                prefix=" \033[1;36m>\033[0m "
            fi
            
            local checkbox="[ ]"
            if [ ${selected[i]} -eq 1 ]; then
                checkbox="[\033[1;32mX\033[0m]"
            fi

            if [ $i -eq $cursor ]; then
                echo -e "${prefix}${checkbox} \033[7m ${options[i]} \033[27m"
            else
                echo -e "${prefix}${checkbox} ${options[i]}"
            fi
        done
        
        echo -e "\n\033[1;30mMostrando $((window_start + 1))-$end de $total skills\033[0m"

        read -rsn1 key
        if [[ $key == $'\e' ]]; then
            read -rsn2 key2
            if [[ $key2 == "[A" ]]; then # Cima
                ((cursor--))
                if [ $cursor -lt 0 ]; then cursor=$((total - 1)); fi
            elif [[ $key2 == "[B" ]]; then # Baixo
                ((cursor++))
                if [ $cursor -ge $total ]; then cursor=0; fi
            fi
            if [ $cursor -lt $window_start ]; then window_start=$cursor; fi
            if [ $cursor -ge $((window_start + window_size)) ]; then window_start=$((cursor - window_size + 1)); fi
        elif [[ $key == " " ]]; then
            if [ ${selected[$cursor]} -eq 0 ]; then selected[$cursor]=1; else selected[$cursor]=0; fi
        elif [[ $key == "" ]]; then # Enter
            break
        fi
    done

    tput cnorm # Restaura o cursor
    
    echo -e "\n\033[1;32mInstalando skills selecionadas...\033[0m"
    local count=0
    for i in "${!options[@]}"; do
        if [ ${selected[i]} -eq 1 ]; then
            cp -r "$CACHE_DIR/${options[i]}" "$SKILLS_DIR/"
            echo -e "  ✅ \033[1;37m${options[i]}\033[0m adicionada ao OpenCode."
            ((count++))
        fi
    done
    if [ $count -eq 0 ]; then echo "Nenhuma skill selecionada."; fi
    echo -e "\n🎉 Processo concluído! Aperte Enter para voltar."
    read -r
}

upload_skill_pr() {
    show_banner
    echo -e "\033[1;33mSubir minhas Skills (Criar Pull Request)\033[0m\n"
    
    cd "$SKILLS_DIR" || exit
    local local_skills=(*/)
    
    if [ ${#local_skills[@]} -eq 0 ] || [ "${local_skills[0]}" == "*/" ]; then
        echo -e "❌ \033[1;31mVocê não tem nenhuma skill local para enviar.\033[0m"
        sleep 3
        return
    fi
    
    echo "Suas skills locais atuais:"
    for i in "${!local_skills[@]}"; do
        local clean_name="${local_skills[$i]%/}"
        echo "  [$((i+1))] $clean_name"
    done
    
    echo ""
    read -p "Digite o NÚMERO da skill que deseja enviar: " skill_num
    local idx=$((skill_num-1))
    local skill_to_upload="${local_skills[$idx]%/}"
    
    if [ -z "$skill_to_upload" ] || [ ! -d "$SKILLS_DIR/$skill_to_upload" ]; then
        echo -e "\033[1;31mOpção inválida!\033[0m"
        sleep 2
        return
    fi
    
    echo -e "\n🔄 Preparando Pull Request para \033[1;36m$skill_to_upload\033[0m..."
    
    sync_repo # Garante que o cache tá atualizado antes de criar a branch
    cd "$CACHE_DIR" || exit
    
    local branch_name="feat/add-skill-$skill_to_upload-$(date +%s)"
    git checkout -b "$branch_name" -q
    
    cp -r "$SKILLS_DIR/$skill_to_upload" "$CACHE_DIR/"
    
    git add "$skill_to_upload"
    git commit -m "feat: adiciona skill $skill_to_upload" -q
    echo "⬆️  Enviando para o GitHub..."
    git push origin "$branch_name" -q
    
    git checkout main -q
    
    echo -e "\n✅ \033[1;32mSkill enviada com sucesso para uma nova branch!\033[0m"
    echo -e "Para finalizar, abra o link abaixo no seu navegador para criar o Pull Request:"
    echo -e "\033[1;34;4m${REPO_WEB_URL}/compare/main...${branch_name}?expand=1\033[0m\n"
    
    read -p "Aperte Enter para voltar ao menu."
}

# ==========================================
# 3. TRATAMENTO DE ARGUMENTOS (CLI agb)
# ==========================================
case "$1" in
    --help|-h)
        echo -e "\033[1;32mAgent Global (agb) - Gerenciador de Skills do OpenCode\033[0m"
        echo -e "Uso: agb [comando]\n"
        echo "Comandos disponíveis:"
        echo "  (vazio)        Abre o menu interativo (TUI)."
        echo "  --help, -h     Mostra esta mensagem de ajuda."
        echo "  --sync, -s     Baixa e sincroniza as skills diretamente."
        echo "  --pr, -p       Abre a interface de Pull Request direto."
        exit 0
        ;;
    --sync|-s)
        sync_repo
        cd "$CACHE_DIR" || exit
        all_skills=()
        for s in */; do
            clean_s="${s%/}"
            if [[ "$clean_s" != .* ]]; then all_skills+=("$clean_s"); fi
        done
        choose_skills_tui "${all_skills[@]}"
        exit 0
        ;;
    --pr|-p)
        upload_skill_pr
        exit 0
        ;;
    "")
        # Nenhuma opção passada, ignora e segue para o Menu Principal abaixo
        ;;
    *)
        echo -e "\033[1;31mComando desconhecido: $1\033[0m"
        echo "Use 'agb --help' para ver os comandos disponíveis."
        exit 1
        ;;
esac

# ==========================================
# 4. MENU PRINCIPAL (Se rodou sem argumentos)
# ==========================================
while true; do
    show_banner
    echo -e "\033[1;33mMenu Principal\033[0m\n"
    echo -e "  [1] Instalar / Atualizar Skills"
    echo -e "  [2] Compartilhar uma Skill (Criar PR)"
    echo -e "  [0] Sair\n"
    read -p "Escolha uma opção: " op
    
    case $op in
        1)
            echo "Sincronizando repositório..."
            sync_repo
            cd "$CACHE_DIR" || exit
            all_skills=()
            for s in */; do
                clean_s="${s%/}"
                if [[ "$clean_s" != .* ]]; then all_skills+=("$clean_s"); fi
            done
            choose_skills_tui "${all_skills[@]}"
            ;;
        2)
            upload_skill_pr
            ;;
        0)
            echo "Até logo, Agent!"
            exit 0
            ;;
        *)
            ;;
    esac
done
