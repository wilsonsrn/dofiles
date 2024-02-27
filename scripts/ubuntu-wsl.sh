#!/usr/bin/env bash

set -x

dir_installation=$(pwd)

echo -e "\n\n### PACOTES PÓS-INSTALAÇÃO DO UBUNTU WSL ### \n\n"
sleep 1
echo -e "---> Atualizando pacotes do Ubuntu. \n"
sleep 2
# Atualização de pacotes do Ubuntu.
sudo apt update
sudo apt upgrade -y

echo -e "\n\n---> Instalando pacotes. \n"
sleep 2

echo -e "\n\n---> Pacotes importantes."
sudo apt install git curl unzip wget fuse libfuse2 zsh cargo -y

cargo --version
sleep 2

echo -e "\n\n---> Torna o ZSH o Shell principal."
chsh -s $(which zsh)

echo -e "\n\n---> Cria pasta de configuração"
mkdir -p ~/.config

echo -e "\n\n---> Instala o Oh-My-ZSH."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e "\n\n---> Instala plugins para ZSH."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "\n\n---> Adiciona plugins em ".zshrc"."
sed -i 's/^plugins=\(.*\)/plugins=(\n  git\n  zsh-syntax-highlighting\n  zsh-autosuggestions\n  )/g' ~/.zshrc

echo -e "\n\n---> Adiciona alguns aliases em ".zshrc"."
echo '# MY ALIASES' >> ~/.zshrc
echo 'alias ls="exa --icons --tree --level=2"' >> ~/.zshrc
echo 'alias vim="lvim"' >> ~/.zshrc

echo -e "\n\n---> Instala Starship"
curl -sS https://starship.rs/install.sh | sh

echo -e "\n\n---> Cria arquivo de configuração do Starship"
touch ~/.config/starship.toml
cp .config/starship.toml ~/.config/

echo -e "\n\n---> Pacotes de dependencias Python para desenvolvimento."
sudo apt install -y aria2 blt-dev build-essential \
checkinstall gettext libbz2-dev libc6-dev libffi-dev \
libgdbm-dev liblzma-dev liblzma-doc libncurses5-dev \
libncursesw5-dev libnss3-dev libnss3-tools libpq-dev \
libreadline-dev libsqlite3-dev libssl-dev llvm lzma \
python3-dev python3-pip python3-venv tcl-dev tk-dev \
xz-utils zlib1g-dev -y
echo -e "\n\n---> Atualiza PIP"
pip install --upgrade pip
echo -e "\n\n---> Instala PIPX"
sudo apt install pipx -y

# Instala Rust
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#source "$HOME/.cargo/env"
# Define as variáveis de ambiente do Rust
#source\_cargo\_env\=</span>(source "$HOME/.cargo/env")
#eval "$source_cargo_env"

echo -e "\n\n---> Configuração do Git"
git config --get --global user.email "wilsonsrochaneto@gmail.com"
git config --get --global user.name "Wilson Rocha Neto"
git config --global core.editor nvim
git config --global credential.helper 'cache --timeout=7200'

echo -e "\n\n---> Instala Git Credential Manager"
curl -L https://aka.ms/gcm/linux-install-source.sh | sh
git-credential-manager configure

echo -e "\n\n---> Instala pacote GitHub"
sudo apt install gh -y
gh auth login -w

echo -e "\n\n---> Instala Neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

echo -e "\n\n---> Instala a versão mais recente do nvm"
NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

echo -e "\n\n---> Atualiza shell"
sleep 2
source ~/.bashrc

echo -e "\n\n---> Instala o Node mais recente"
nvm install node

echo -e "\n\n---> Pacote adicionais em Rust"
cargo install ripgrep
cargo install exa

echo -e "\n\n---> Instala LazyGit"
mkdir -p ~/.stuff
cd ~/.stuff
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
cd $dir_installation

echo -e "\n\n---> Instala Pyenv"
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

echo -e "\n\n---> Instala Poetry"
pipx install poetry

echo -e "\n\n---> Pacotes bestas."
sudo apt install neofetch htop -y

echo -e "\n\n---> Instala Tmux e Oh-My-Tmux!"
sudo apt install tmux -y
git clone https://github.com/gpakosz/.tmux.git "/path/to/oh-my-tmux"
mkdir -p "~/.config/tmux"
ln -s "/path/to/oh-my-tmux/.tmux.conf" "~/.config/tmux/tmux.conf"
cp "/path/to/oh-my-tmux/.tmux.conf.local" "~/.config/tmux/tmux.conf.local"

echo -e "\n\n---> Instala LunarVim"
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

echo -e "\n\n---> Baixa Config geral LunarVim do repositorio wilsonsrn"
cd ~/.config
mv lvim lvim-orig
git clone https://github.com/wilsonsrn/my-lunarvim.git lvim
