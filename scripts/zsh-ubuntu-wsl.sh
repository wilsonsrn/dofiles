#!/usr/bin/env zsh

set +x

dir_installation=$('~/dotfiles')

printf " Atualização de pacote no ZSH.\n"
sudo apt update
sudo apt upgrade -y

printf "\n\n---> Pacotes importantes."
sudo apt install git curl unzip wget fuse libfuse2 -y
sleep 1

printf "\n\n---> Pacotes bestas."
sudo apt install neofetch htop -y
sleep 1

printf "\n\n---> Cria pasta de configuração."
mkdir -p ~/.config
sleep 1

printf "\n\n---> Instala o Oh-My-ZSH.\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sleep 1

printf "\n\n---> Instala plugins para ZSH."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sleep 1

printf '\n\n---> Adiciona plugins em ".zshrc".'
sed -i 's/^plugins=\(.*\)/plugins=(\n  git\n  zsh-syntax-highlighting\n  zsh-autosuggestions\n  )/g' ~/.zshrc
sleep 1

printf '\n\n---> Adiciona alguns aliases em ".zshrc".'
echo '' >> ~/.zshrc
echo '# MY ALIASES' >> ~/.zshrc
echo 'alias ls="exa --icons --tree --level=2"' >> ~/.zshrc
echo 'alias vim="lvim"' >> ~/.zshrc
sleep 1

printf "\n\n---> Instala Starship.\n"
curl -sS https://starship.rs/install.sh | sh
sleep 1

printf "\n\n---> Adiciona arquivo de configuração do Starship."
touch ~/.config/starship.toml
cp .config/starship.toml ~/.config/
sleep 1

printf "\n\n---> Pacotes de dependencias Python para desenvolvimento."
sudo apt install -y aria2 blt-dev build-essential \
checkinstall gettext libbz2-dev libc6-dev libffi-dev \
libgdbm-dev liblzma-dev liblzma-doc libncurses5-dev \
libncursesw5-dev libnss3-dev libnss3-tools libpq-dev \
libreadline-dev libsqlite3-dev libssl-dev llvm lzma \
python3-dev python3-pip python3-venv tcl-dev tk-dev \
xz-utils zlib1g-dev -y
sleep 1

printf "\n\n---> Atualiza PIP."
pip install --upgrade pip
sleep 1

printf "\n\n---> Instala PIPX."
sudo apt install pipx -y
sleep 1

printf "\n\n---> Instala Rust."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
#export PATH="\$HOME/.cargo/bin:\$PATH"
#printf "\n\n---> Define as variáveis de ambiente do Rust"
#source\_cargo\_env\=</span>(source "$HOME/.cargo/env")
#eval "$source_cargo_env"
sleep 1

printf "\n\n---> Configuração do Git."
git config --get --global user.email "wilsonsrochaneto@gmail.com"
git config --get --global user.name "Wilson Rocha Neto"
git config --global core.editor nvim
git config --global credential.helper 'cache --timeout=7200'
sleep 1

printf "\n\n---> Instala Git Credential Manager."
curl -L https://aka.ms/gcm/linux-install-source.sh | sh
git-credential-manager configure
sleep 1

printf "\n\n---> Instala pacote GitHub."
sudo apt install gh -y
gh auth login -w
sleep 1

printf "\n\n---> Instala Neovim."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
sleep 1

printf "\n\n---> Pacote adicionais em Rust."
cargo install ripgrep
cargo install exa
sleep 1

printf "\n\n---> Instala LazyGit."
mkdir -p ~/.stuff
cd ~/.stuff
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
cd $dir_installation
sleep 1

printf "\n\n---> Instala Pyenv."
curl https://pyenv.run | bash
echo '' >> ~/.zshrc
echo '# PYENV' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
sleep 1

printf "\n\n---> Instala Poetry."
pipx install poetry
sleep 1

printf "\n\n---> Adiciona PIPX ao PATH."
pipx ensurepath
sleep 1

printf "\n\n---> Instala a versão mais recente do nvm."
NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash
sleep 1

printf "\n\n---> Atualiza Zsh shell."
sleep 2
source ~/.zshrc
sleep 1

printf "\n\n---> Instala o Node mais recente."
nvm install node
sleep 1

printf "\n\n---> Instala Tmux e Oh-My-Tmux!"
sudo apt install tmux -y
git clone https://github.com/gpakosz/.tmux.git "/path/to/oh-my-tmux"
mkdir -p "~/.config/tmux"
ln -s "/path/to/oh-my-tmux/.tmux.conf" "~/.config/tmux/tmux.conf"
cp "/path/to/oh-my-tmux/.tmux.conf.local" "~/.config/tmux/tmux.conf.local"
sleep 1

printf "\n\n---> Instala LunarVim."
cd ~
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
sleep 1

printf "\n\n---> Baixa Config geral LunarVim do repositorio wilsonsrn."
cd ~/.config
mv lvim lvim-orig
git clone https://github.com/wilsonsrn/my-lunarvim.git lvim

printf "\n\n---> Zsh script finalizado."
sleep 1
