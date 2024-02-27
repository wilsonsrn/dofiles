#!/usr/bin/env bash

set +x

echo -e "\n\n### PACOTES PÓS-INSTALAÇÃO DO UBUNTU WSL ### \n\n"
sleep 1
echo -e "---> Atualizando pacotes do Ubuntu. \n"
sleep 2
echo -e " Atualização de pacotes do Ubuntu."
sudo apt update
sudo apt upgrade -y

echo -e "\n\n---> Instalando pacotes. \n"
sleep 2

echo -e "\n\n---> Instala o shell ZSH."
sudo apt install zsh -y

echo -e "\n\n---> Torna o ZSH o Shell principal.\n"
chsh -s $(which zsh)

echo -e "\n\n---> Inicia script no ZSH."
sh ./scripts/zsh-ubuntu-wsl.sh

echo -e "\n\n---> Bash script finalizado!"
