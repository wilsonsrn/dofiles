#!/usr/bin/env zsh

dir_installation=~/dotfiles

printf "\n\n### PACOTES PÓS-INSTALAÇÃO DO UBUNTU WSL ### \n\n"
printf "---> Atualização de pacotes do Ubuntu.\n"
sleep 1
sudo add-apt-repository universe
sudo apt update
sudo apt upgrade -y

printf "\n\n---> Pacotes importantes.\n"
sleep 1
sudo apt install git curl unzip wget libfuse2 -y

printf "\n\n---> Pacotes bestas.\n"
sleep 1
sudo apt install neofetch htop -y

printf "\n\n---> Cria pasta de configuração.\n"
sleep 1
mkdir -p ~/.config

printf "\n\n---> Instala o Oh-My-ZSH.\n"
sleep 1
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

printf "\n\n---> Instala plugins para ZSH.\n"
sleep 1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

printf '\n\n---> Adiciona plugins em ".zshrc".\n'
sleep 1
sed -i 's/^plugins=\(.*\)/plugins=(\n  git\n  zsh-syntax-highlighting\n  zsh-autosuggestions\n  thefuck\n)/g' ~/.zshrc

printf '\n\n---> Adiciona alguns aliases em ".zshrc".\n'
sleep 1
echo '' >> ~/.zshrc
echo '# MY ALIASES' >> ~/.zshrc
echo 'alias ls="exa --icons --tree --level=2"' >> ~/.zshrc
echo 'alias vim="lvim"' >> ~/.zshrc
echo 'alias penv="source \$(poetry env info --path)/bin/activate"' >> ~/.zshrcv

printf "\n\n---> Instala Starship.\n"
sleep 1
curl -sS https://starship.rs/install.sh | sh
echo '' >> ~/.zshrc
echo '# Starship init' >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

printf "\n\n---> Adiciona arquivo de configuração do Starship.\n"
sleep 1
cp $dir_installation/.config/starship.toml ~/.config/

printf "\n\n---> Pacotes de dependencias Python para desenvolvimento.\n"
sleep 1
sudo apt install -y aria2 blt-dev build-essential \
checkinstall gettext libbz2-dev libc6-dev libffi-dev \
libgdbm-dev liblzma-dev liblzma-doc libncurses5-dev \
libncursesw5-dev libnss3-dev libnss3-tools libpq-dev \
libreadline-dev libsqlite3-dev libssl-dev llvm lzma \
python3-dev python3-pip python3-venv tcl-dev tk-dev \
xz-utils zlib1g-dev -y

printf "\n\n---> Atualiza PIP.\n"
sleep 1
pip install --upgrade pip

printf "\n\n---> Instala PIPX.\n"
sleep 1
sudo apt install pipx -y

printf "\n\n---> Instala Rust.\n"
sleep 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

#printf "\n\n---> Instala Git Credential Manager.\n"
#sleep 1
#mkdir -p ~/.stuff
#cd ~/.stuff
#GCM_VERSION=$(curl -s "https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
#wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v$GCM_VERSION/gcm-linux_amd64.$GCM_VERSION.deb
#GCM_FILE=$(find gcm*)
#sudo dpkg -i $GCM_FILE
#git-credential-manager configure
#cd $dir_installation

printf "\n\n---> Configuração do Git.\n"

echo "Digite seu nome de usuário Git: "
read nome_git
echo "Digite seu email Git: "
read email_git

git config --global user.name $nome_git
git config --global user.email $email_git
git config --global core.editor nvim
git config --global credential.credentialStore store
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
sleep 1

printf "\n\n---> Instala pacote GitHub.\n"
sleep 1
sudo apt install gh -y

printf "\n\n---> Instala Neovim.\n"
sleep 1
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

printf "\n\n---> Instala LazyGit.\n"
sleep 1
mkdir -p ~/.stuff
cd ~/.stuff
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
cd $dir_installation

printf "\n\n---> Instala Pyenv.\n"
sleep 1
curl https://pyenv.run | bash
echo '' >> ~/.zshrc
echo '# PYENV' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

printf "\n\n---> Instala Poetry.\n"
sleep 1
pipx install poetry

printf "\n\n---> Instala TheFuck.\n"
sleep 1
pipx install thefuck

printf "\n\n---> Adiciona PIPX ao PATH.\n"
sleep 1
pipx ensurepath

printf "\n\n---> Instala Pynvim.\n"
sleep 1
pip install pynvim

printf "\n\n---> Instala a versão mais recente do nvm.\n"
sleep 1
echo '# NVM' >> ~/.zshrc
NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

printf "\n\n---> Atualiza Zsh shell.\n"
sleep 1
source ~/.zshrc

printf "\n\n---> Instala suporte node para Neovim.\n"
sleep 1
cd 
npm i -g neovim

printf "\n\n---> Pacote adicionais em Rust.\n"
sleep 1
cargo install ripgrep
cargo install exa

printf "\n\n---> Atualiza Zsh shell.\n"
sleep 1
source ~/.zshrc

printf "\n\n---> Instala o Node mais recente.\n"
nvm install node
sleep 1

printf "\n\n---> Atualiza Zsh shell.\n"
sleep 1
source ~/.zshrc

printf "\n\n---> Instala Tmux e Oh-My-Tmux!\n"
sleep 1
sudo apt install tmux -y
cd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

printf "\n\n---> Instala LunarVim.\n"
sleep 1
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

#printf "\n\n---> Baixa Config geral LunarVim do repositorio wilsonsrn.\n"
#sleep 1
#cd ~/.config
#mv lvim lvim-orig
#git clone https://github.com/wilsonsrn/my-lunarvim.git lvim
#cd $dir_installation

printf "\n\n---> Shell script finalizado.\n"
sleep 3
