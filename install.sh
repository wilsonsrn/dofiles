#!/usr/bin/env zsh

# Configurações

set -e

scripts_dir="./scripts"

# Listas
distros=(ubuntu-wsl)
scripts=()

# Funções

# Verifica e altera permissões
function check_permissions() {
  for file in "$@"; do
    if ! [[ -f "$file" ]]; then
      echo "Erro: Arquivo '$file' não encontrado."
      continue
    fi

    if ! [[ -x "$file" ]]; then
      echo "Alterando permissões de '$file' para +x..."
      chmod +x "$file"
    fi
  done
}

# Mostra o menu de seleção
function select_distro() {
  echo "\n\n### PÓS-INSTALAÇÃO DE DISTROS UNIX ###\n\n"

  echo "Qual instalação deseja executar?"

  for (( i=0; i<${#distros[@]}; i++ )); do
    echo "[$(($i+1))] ${distros[$i]}"
  done

  echo "[0] Sair"

  read -p "Digite o número da distro: " selected_distro

  if ! [[ $selected_distro =~ ^[0-9]+$ ]]; then
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

# Script principal

# Carrega scripts .sh e .zsh
for distro in "${distros[@]}"; do
  script_file="$scripts_dir/$distro.sh"
  zsh_script_file="$scripts_dir/zsh-$distro.sh"

  if [[ -f "$script_file" ]]; then
    scripts+=("$script_file")
  else
    echo "Erro: Script '$script_file' não encontrado."
  fi

  if [[ -f "$zsh_script_file" ]]; then
    scripts+=("$zsh_script_file")
  else
    echo "Erro: Script '$zsh_script_file' não encontrado."
  fi
done

# Verifica permissões
check_permissions "${scripts[@]}"

# Exibe menu de seleção
select_distro
