# My Dotfiles!

> Esse é um repositório para automação das minhas configurações de uma pós-instalação de distros Unix.

## Usage

1 - Primeiramente é necessário instalar o shell *Zsh*. Portanto, execute:

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install zsh -y
chsh -s $(which zsh)
```

2 - Então apenas execute os comandos abaixo para iniciar o instalador:

```bash
git clone https://github.com/wilsonsrn/dotfiles.git && cd dotfiles
chmod +x install.sh
./install.sh
```

## Manual Installation

Siga os passos abaixo em sequência.

Atualiza repositório e pacotes:
```bash
sudo add-apt-repository universe
sudo apt update
sudo apt upgrade -y
```

<br/>

Instala Zsh.
```bash
sudo apt install zsh -y
chsh -s $(which zsh)
```

<br/>

Pacotes importantes:
```bash
sudo apt install git curl unzip wget libfuse2 -y
```

<br/>

Pacotes bestas (opcional).
```bash
sudo apt install neofetch htop -y
```

<br/>

Instala Oh-My-Zsh!.
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

<br/>

Instala plugins para Zsh.
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

<br/>

Adiciona plugins em *.zshrc*. 
```bash
sed -i 's/^plugins=\(.*\)/plugins=(\n  git\n  zsh-syntax-highlighting\n  zsh-autosuggestions\n  )/g' ~/.zshrc
```
>> Opcionalmente você pode adicionar *zsh-syntax-highlighting* e *zsh-autosuggestions* em `plugins=()` de *.zshrc*.

<br/>

Adiciona alguns aliases em *.zshrc*.
```bash
echo -e '\n# MY ALIASES' >> ~/.zshrc
echo 'alias ls="exa --icons --tree --level=2"' >> ~/.zshrc
echo 'alias vim="lvim"' >> ~/.zshrc
```

<br/>

Instala Starship.
```bash
curl -sS https://starship.rs/install.sh | sh
echo -e '\n# Starship init' >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

<br/>

Primeiro criamos o arquivo de configuração do Starship.
```bash
mkdir -p ~/.config
touch ~/.config/starship.toml
```
Copie o conteúdo de [starship.toml](.config/starship.toml) para esse arquivo de mesmo nome.

<br/>

Pacotes de dependencias Python para desenvolvimento.
```bash
sudo apt install -y aria2 blt-dev build-essential \
checkinstall gettext libbz2-dev libc6-dev libffi-dev \
libgdbm-dev liblzma-dev liblzma-doc libncurses5-dev \
libncursesw5-dev libnss3-dev libnss3-tools libpq-dev \
libreadline-dev libsqlite3-dev libssl-dev llvm lzma \
python3-dev python3-pip python3-venv tcl-dev tk-dev \
xz-utils zlib1g-dev -y
```
<br/>

Atualiza PIP.
```bash
pip install --upgrade pip
```

<br/>

Instala PIPX.
```bash
sudo apt install pipx -y
```

<br/>

Instala Rust.
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

<br/>

Configuração do Git.
```bash
git config --get --global user.email "xxxxxx@gmail.com"
git config --get --global user.name "Wilson XXXXX"
git config --global core.editor nvim
git config --global credential.helper 'cache --timeout=7200'
```

<br/>

Instala Git Credential Manager.
```bash
curl -L https://aka.ms/gcm/linux-install-source.sh | sh
git-credential-manager configure
```

<br/>

Instala pacote GitHub.
```bash
sudo apt install gh -y
gh auth login
```

<br/>

Instala Neovim.
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

<br/>

Pacotes adicionais em Rust.
```bash
cargo install ripgrep
cargo install exa
```

<br/>

Instala LazyGit.
```bash
mkdir -p ~/.stuff
cd ~/.stuff
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

<br/>

Instala Pyenv.
```bash
curl https://pyenv.run | bash
echo '' >> ~/.zshrc
echo '# PYENV' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

<br/>

Instala Poetry.
```bash
pipx install poetry
```

<br/>

Adiciona PIPX ao PATH.
```bash
pipx ensurepath
```

<br/>

Instala a versão mais recente do nvm.
```bash
NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
```

<br/>

Instala o Node mais recente.
```bash
nvm install node
```

<br/>

Instala Tmux e Oh-My-Tmux!
```bash
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
```

<br/>

Instala LunarVim.
```bash
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
```

<br/>

Baixa Config geral LunarVim do repositorio *wilsonsrn*.
```bash
cd ~/.config
mv lvim lvim-orig
git clone https://github.com/wilsonsrn/my-lunarvim.git lvim
```
