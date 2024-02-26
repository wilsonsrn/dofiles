#!/usr/bin/env bash

set -e

# Lista de distros disponíveis
distros=(ubuntu-wsl)

# Função para mostrar o menu de seleção
function select_distro() {
    echo "Qual instalação deseja executar?"
    for (( i=0; i<${#distros[@]}; i++ )); do
        echo "[$(($i+1))] ${distros[$i]}"
    done
    echo "[0] Sair"

    read -p "Digite o número da distro: " selected_distro

    if [[ ! $selected_distro =~ ^[0-9]+$ ]]; then
        echo "Opção inválida!"
        exit 1
    fi

    if [[ $selected_distro -eq 0 ]]; then
        echo "Saindo..."
        exit 0
    fi

    selected_distro=${distros[$(($selected_distro-1))]}

    echo "Selecionado: $selected_distro"

    # Chamar o script específico da distro
    ./scripts/$selected_distro.sh
}

# Início do script
select_distro
