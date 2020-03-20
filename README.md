# PC config

Um checklist de configuração que sigo após realizar uma instalação limpa do Ubuntu, para uso pessoal
e também de desenvolvimento.

## Checklist resumido

- Executar o script [instAll.sh](instAll.sh). ***Se for usar o script, lembre-se de alterar o usuário e email do github***;
- Personalizar o terminal ([etapa 3](#3-personalizar-terminal-usando-zsh)), assim já instalo o zsh;
- Copiar conteúdo do arquivo [bashrc_zshrc-config.txt](bashrc_zshrc-config.txt) para .zshrc;
- Instalar RStudio e Anaconda;
- Copiar as preferências do Sublime em [Preferences.sublime-settings](Preferences.sublime-settings)
e importar o arquivo [pycharm-settings.zip](pycharm-settings.zip) no PyCharm.

## Checklist detalhado

Antes de tudo:
```
sudo apt update
sudo apt upgrade -y
```

Também instalo alguns programas com snap (sim, eu uso), então, pra garantir:
```
sudo apt install snapd
```

Para instalar alguns softwares, que não vem por .deb nem snap, costumo usar um diretório separado na
home do usuário, chamado **opt**, de *optional*.
```
cd
mkdir opt
```

### 1. Uso pessoal: Navegador, multimídia, manipulação de imagens, mensagens, etc.

Eu gosto do Firefox, mas, por costume (e alguns detalhes), vamos de Google Chrome de navagador.
```
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
```

Se você marcou para baixar os pacotes de terceiros durante a instalação do Ubuntu, não precisa dessa
etapa, que instala alguns softwares adicionais proprietários, principalmente para reprodução de mídia.
```
sudo apt install -y ubuntu-restricted-extras
```

Para ouvir música, Spotify, e para vídeos e CD's(!), VLC.
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt install -y spotify-client
sudo snap install vlc
```

Para mensagens, uso o Telegram, mas sempre acaba tendo que usar Slack e Skype também. Se o Telegram
mudar o link, podemos fazer o processo manualmente, baixando em [https://desktop.telegram.org/](https://desktop.telegram.org/).
```
cd ~/opt
wget -c -O telegram.tar.xz https://telegram.org/dl/desktop/linux
tar -xvJf telegram.tar.xz
rm telegram.tar.xz

sudo snap install slack --classic
sudo snap install skype --classic
```

Costumo usar o comando ```df``` para ver o espaço usado nos dicos do PC, mas no Ubuntu, os snaps
poluem ~~um pouco~~ a saída, então, adicionei o *alias* abaixo no arquivo .zshrc para não mostrar
os snaps.
```
alias dfws='df -h | grep -v "snap"'
```

Se der vontade de mais wallpapers e alguns temas.
```
sudo apt install -y "ubuntu-wallpapers ubuntu-wallpapers-*"
sudo apt install -y "ubuntu-gnome-wallpapers ubuntu-gnome-wallpapers-*"
sudo apt -y install arc-theme
sudo apt -y install numix-gtk-theme
sudo apt -y install numix-icon-theme numix-icon-theme-circle
```

Por fim, alguns comandos para dar uma limpada no sistema.
```
# Checar espaço usado pelo cache do apt
sudo du -sh /var/cache/apt/archives
# liberar espaço usado pelo cache do apt
sudo apt clean
# remover kernels antigos
sudo apt autoremove --purge
```

### 2. Desenvolvimento e outros utilitários

Algumas ferramentas básicas.
```
sudo apt install -y vim htop curl git ssh sshfs
```

Configurar o usuario e email para o git:
```
git config --global user.name "Nome Nome"
git config --global user.email nome@mail.com
```

Também lembrar de gerar a chave para o ssh, sempre precisa dela:
```
ssh-keygen -t rsa -C "nome@mail.com" -b 4096
cat ~/.ssh/id_rsa.pub
```

Para desenvolvimento, Sublime e PyCharm (VSCode talvez...).
```
sudo snap install sublime-text --classic
sudo snap install pycharm-community --classic
# sudo snap install code --classic
```

No Sublime, ir em *Preferences > Settings* e colocar o conteúdo do arquivo
[Preferences.sublime-settings](Preferences.sublime-settings).

No PyCharm, ir em *File > Import Settings* e selecionar o arquivo [pycharm-settings.zip](pycharm-settings.zip).

Já que uso Python, vamos de pyenv.
```
curl https://pyenv.run | bash
```

Garantindo que tem as dependências.
```
sudo apt-get install -y \
  make \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  curl \
  llvm \
  libncurses5-dev \
  libncursesw5-dev \
  xz-utils \
  tk-dev \
  libffi-dev \
  liblzma-dev \
  python-openssl \
  git
```

Adicionar as seguintes linhas no final do seu arquivo .bashrc ou .zshrc ou...
```
# add .bashrc or .zshrc
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

Reiniciar o terminal, fechando e abrindo de novo ou executando o comando ```exec $SHELL```.

Um exemplo de como instalar uma versão do Python com pyenv, criar um ambiente virtual com essa versão
e ativar o ambiente.
```
pyenv install 3.7.5

pyenv virtualenv 3.7.5 venv-meu-projeto
mkdir dir-meu-projeto
cd dir-meu-projeto
# o comando abaixo cria um arquivo oculto que permite ao pyenv habilitar ou desabilitar o ambiente
# virtual ao entrar ou sair do diretório do projeto
pyenv local venv-meu-projeto

# para ativar o ambiente estando fora do diretorio do projeto
pyenv activate venv-meu-projeto
pyenv deactivate
```

Mexendo na área de ciência de dados e aprendizado de máquina, vai acabar usando a linguagem R.
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt update
sudo apt install -y r-base r-base-dev

# verificando a versão instalada
R --version
```

Lembrar de baixar o RStudio em [https://rstudio.com/products/rstudio/download/#download](https://rstudio.com/products/rstudio/download/#download).

Vai acabar usando Anaconda também. Baixar a versão mais recente em [https://www.anaconda.com/distribution/#download-section](https://www.anaconda.com/distribution/#download-section)
e executar o arquivo baixado:
```
bash Anaconda3-YYYY.mm-Linux-x86_64.sh
```

Para brincar com desenvolvimento Android e Flutter, não vou colocar as etapas para download, apenas
um lebrete do que configurar no arquivo .zshrc ou .bashrc ou...
```
# Para Android
export ANDROID_HOME=$HOME/opt/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Para Flutter
export PATH="$PATH:$HOME/opt/flutter/bin"
```

Não chega a ser 100% relacionado a desenvolvimento, mas é uma ferramenta que é útil ao trabalhar com
dados geoespaciais, o QGis. Checar em [https://www.qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu](https://www.qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu)
o codinome da versão do Ubuntu e colocar no lugar de *bionic*.
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 51F523511C7028C3
sudo add-apt-repository 'deb     https://qgis.org/ubuntu-ltr bionic main'
sudo add-apt-repository 'deb-src https://qgis.org/ubuntu-ltr bionic main'
sudo apt update
sudo apt install qgis qgis-plugin-grass
```

### 3. Personalizar terminal, usando zsh.

Instalar zsh e Oh My Zsh:
```
sudo apt -y install zsh
cd && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Baixar o tema PowerLevel9k:
```
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

Editar o arquivo **~/.zshrc**, alterando o tema na variável ZSH_THEME e adicionar as variáveis do
PowerLevel9k:
```
ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon time context dir pyenv anaconda vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs ram disk_usage ip)
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_PYENV_BACKGROUND='184'
POWERLEVEL9K_ANACONDA_BACKGROUND='040'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
```

Instalar a fonte Hack, baixando a versão mais recente em:
- [https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)

Extrair os arquivos .ttf e mover para \~/.local/share/fonts (se não existir: mkdir -p \~/.local/share/fonts):
```
mv *.ttf $HOME/.local/share/fonts
```

Baixar o arquivo de configuração de fontes, mover para o diretório de configuração (se não existir:
mkdir -p \~/.config/fontconfig/conf.d/), limpar e gerar novamente o cache da fontes:
```
wget -c https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/10-nerd-font-symbols.conf && mv 10-nerd-font-symbols.conf ~/.config/fontconfig/conf.d/
fc-cache -f -v .local/share/fonts
```

Selecionar a fonte Hack Regular no terminal usado, usando tamanho 11.

**Obs.**: A fonte Hack do nerd-fonts não estava exibindo os ícones, resolvido ao tentar usar a
[Awesome-Powerline Fonts](https://github.com/gabrielelana/awesome-terminal-fonts).  
```
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git
cd awesome-terminal-fonts
./install.sh
rm awesome-terminal-fonts-master -rf
```

Alterei o POWERLEVEL9K_MODE no .zshrc de nerdfont-complete para awesome-fontconfig e reiniciei o terminal...
```
exec $SHELL
```

e funcionou a fonte Hack! E se seleciono uma das fontes do awesome fonts, não funciona ¯\\\_(ツ)\_/¯

Configurar então o terminal para usar o zsh, no caso do GNOME Terminal, em Edit > Preferences > Command, 
colocar **/usr/bin/zsh** como "Custom command".

### 4. Outros

Ah, tem o script [compila_tex.sh](compila_tex.sh), caso venha a usar LaTeX novamente algum dia.

## Referências

**Uso pessoal**
- [https://www.google.com/intl/pt-BR/chrome/](https://www.google.com/intl/pt-BR/chrome/)
- [https://snapcraft.io/](https://snapcraft.io/)
- [https://www.spotify.com/br/download/linux/](https://www.spotify.com/br/download/linux/)
- [http://www.omgubuntu.co.uk/2016/08/5-ways-free-up-space-on-ubuntu](http://www.omgubuntu.co.uk/2016/08/5-ways-free-up-space-on-ubuntu)

**Desenvolvimento**
- [https://medium.com/@Joachim8675309/installing-pythons-with-pyenv-54cca2196cd3](https://medium.com/@Joachim8675309/installing-pythons-with-pyenv-54cca2196cd3)
- [https://github.com/pyenv/pyenv-installer](https://github.com/pyenv/pyenv-installer)
- [https://cran.r-project.org/bin/linux/ubuntu/#installation](https://cran.r-project.org/bin/linux/ubuntu/#installation)
- [https://rstudio.com/products/rstudio/download/#download](https://rstudio.com/products/rstudio/download/#download)
- [https://flutter.dev/docs/get-started/install/linux](https://flutter.dev/docs/get-started/install/linux)
- [https://developer.android.com/studio](https://developer.android.com/studio)
- [https://www.qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu](https://www.qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu)

**Personalização do terminal**
- [https://medium.com/@alex285/get-powerlevel9k-the-most-cool-linux-shell-ever-1c38516b0caa](https://medium.com/@alex285/get-powerlevel9k-the-most-cool-linux-shell-ever-1c38516b0caa)
- [https://github.com/Powerlevel9k/powerlevel9k#prompt-customization](https://github.com/Powerlevel9k/powerlevel9k#prompt-customization)
- [https://github.com/ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
- [https://github.com/gabrielelana/awesome-terminal-fonts](https://github.com/gabrielelana/awesome-terminal-fonts)

**Inspiração checklist**
- [https://github.com/mdo/config](https://github.com/mdo/config)

