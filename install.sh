#!/usr/bin/env zsh

set -e

scripts_dir="./scripts"

# Lista de distros disponíveis
distros=(ubuntu-wsl)

# Lista de scripts .sh
scripts=()

# Funções

# Verifica e altera permissões
function check_permissions() {
  for file in "$@"; do
    if [[ ! -f "$file" ]]; then
      echo "Erro: Arquivo '$file' não encontrado."
      continue
    fi

    if [[ ! -x "$file" ]]; then
      echo "Alterando permissões de '$file' para +x..."
    fi
  done
}

# Mostra o menu de seleção
function select_distro() {
  echo "Qual instalação deseja executar?"
  enum=1
  for distro in distros; do
    echo "[$enum] ${distros[$enum]}"
    ((enum++))
  done
  echo "[0] Sair"

  echo -n "Digite o número da distro: "
  read selected_distro

  if [[ ! $selected_distro =~ ^[0-9]+$ ]]; then
    echo "Opção inválida!"
    exit 1
  fi

  if [[ $selected_distro -eq 0 ]]; then
    echo "Saindo..."
    exit 0
  fi

  selected_distro=${distros[$(($selected_distro))]}

  echo "Selecionado: $selected_distro"
  
  # Chamar o script específico da distro
  zsh ./scripts/$selected_distro.sh
}

# Script principal

# Carrega scripts .sh e .zsh
for distro in "${distros[@]}"; do
  script_file="$scripts_dir/$distro.sh"
  zsh_script_file="$scripts_dir/zsh-$distro.sh"
  echo "# 1 LOOP"

  if [[ -f "$script_file" ]]; then
    echo "Existe 1"
    scripts+=("$script_file")
  else
    echo "Erro: Script '$script_file' não encontrado."
  fi
  if [[ -f "$zsh_script_file" ]]; then
    echo "Existe 2"
    scripts+=("$zsh_script_file")
  else
    echo "Erro: Script '$zsh_script_file' não encontrado."
  fi
done

# Verifica permissões
check_permissions "${scripts[@]}"

# Exibe menu de seleção
select_distro
