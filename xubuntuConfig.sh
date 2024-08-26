#!/bin/bash

# Atualizar o sistema
echo -e "${boldGreen}\nAtualizando o sistema...\n${reset}"

sudo apt update > /dev/null 2>&1 && sudo apt upgrade -y > /dev/null 2>&1

#Instalar o nala
echo "deb [arch=amd64,arm64,armhf] http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala

# Captura o nome do usuário atual
currentUser=$(whoami)

# Cria diretórios para o usuário atual
sudo -u "$currentUser" mkdir -p "/home/$currentUser/{Desktop,Documents,Downloads,Pictures,Videos,Music,Public,Templates}"
sudo -u "$currentUser" mkdir -p "/home/$currentUser/.config/xfce4"

# Definir a sequência de escape para verde negrito e vermelho negrito
boldGreen="\033[1;32m"
boldRed="\033[1;31m"
reset="\033[0m"

# Atualizar o sistema e instalar pacotes desejados
sudo nala update && sudo nala upgrade -y && \
echo -e "${boldGreen}\nInstalando pacotes que eu sempre uso...\n${reset}"
sudo nala install -y most wmctrl sc-im xdotool nodejs npm p7zip-full bat vim git curl wget build-essential software-properties-common alacritty acpi acpid bc blueman brightnessctl btop cron dpkg dpkg-dev efibootmgr elementary-xfce-icon-theme gimp gimp-data gimp-help-common gimp-help-en gnome-keyring htop iotop locales login lua-luv make man-db manpages manpages-dev mate-calc mate-calc-common micro mount mousepad mugshot nala nano neovim neovim-runtime pandoc pandoc-data parted passwd pipewire pipewire-bin qt5-gtk-platformtheme rclone ripgrep rsync rsyslog sudo systemd tar terminator thunar thunar-archive-plugin thunar-data thunar-media-tags-plugin thunar-volman time timeshift tmux tree ubuntu-keyring vim virtualbox virtualbox-dkms virtualbox-qt wget wireless-tools xcursor-themes xcvt xdg-dbus-proxy xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils xfburn xfce4-appfinder xfce4-clipman xfce4-clipman-plugin xfce4-cpugraph-plugin xfce4-dict xfce4-helpers xfce4-indicator-plugin xfce4-mailwatch-plugin xfce4-netload-plugin xfce4-notes xfce4-notes-plugin xfce4-notifyd xfce4-panel xfce4-panel-profiles xfce4-places-plugin xfce4-power-manager xfce4-power-manager-data xfce4-power-manager-plugins xfce4-pulseaudio-plugin xfce4-screensaver xfce4-screenshooter xfce4-session xfce4-settings xfce4-systemload-plugin xfce4-taskmanager xfce4-terminal xfce4-verve-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin xfconf xfdesktop4 xfdesktop4-data xfonts-base xfonts-encodings xfonts-scalable xfonts-utils xfwm4 x11-xserver-utils python3 python3-apt python3-apport python3-attr python3-babel python3-bs4 python3-cairo python3-certifi python3-cffi python3-cffi-backend python3-chardet python3-charset-normalizer python3-click python3-colorama python3-commandnotfound python3-cryptography python3-dateutil python3-dbus python3-debconf python3-debian python3-distro python3-distupgrade python3-flake8 python3-full python3-gdbm python3-gi python3-gi-cairo python3-html5lib python3-httplib2 python3-idna python3-importlib-metadata python3-jinja2 python3-keyring python3-lxml python3-mako python3-markdown python3-markupsafe python3-minimal python3-msgpack python3-neovim python3-netifaces python3-oauthlib python3-packaging python3-pexpect python3-pil python3-pip python3-pkg-resources python3-psutil python3-ptyprocess python3-py python3-pycodestyle python3-pycparser python3-pyflakes python3-pygments python3-pyinotify python3-pynvim python3-pyparsing python3-pytest python3-pytest-cov python3-reportlab python3-requests python3-secretstorage python3-setuptools python3-six python3-soupsieve python3-toml python3-typing-extensions python3-update-manager python3-urllib3 python3-yaml || { echo -e "${boldRed}\nFalha ao instalar pacotes.\n${reset}"; exit 1; }


# Clonar repositórios de temas e instalar
echo -e "${boldGreen}\nClonando repositórios de temas e instalando...\n${reset}"
mkdir -p ~/Themes && cd ~/Themes && \
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme && \
cd WhiteSur-gtk-theme && \
./install.sh --darker -t red -i zorin --round && \
cd .. && \
git clone https://github.com/yeyushengfan258/Win11-icon-theme && \
cd Win11-icon-theme && \
./install.sh -a && \
cd .. && \
git clone https://github.com/vinceliuice/WhiteSur-cursors && \
cd WhiteSur-cursors && \
./install.sh || { echo -e "${boldRed}\nFalha ao instalar temas.\n${reset}"; exit 1; }

# Instalar Roboto Mono Nerd Font
echo -e "${boldGreen}\nInstalando Roboto Mono Nerd Font...\n${reset}"
cd ~/Downloads
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/RobotoMono.tar.xz
sudo 7z x RobotoMono.tar.xz -o/usr/share/fonts || { echo -e "${boldRed}\nFalha ao instalar Roboto Mono Nerd Font.\n${reset}"; exit 1; }

# Instalar Roboto Mono
echo -e "${boldGreen}\nInstalando Roboto Mono...\n${reset}"
cd ~/Downloads
git clone https://github.com/googlefonts/RobotoMono && \
cd RobotoMono/fonts/ttf && \
sudo mkdir -p /usr/share/fonts/RobotoMono && \
sudo cp *.ttf /usr/share/fonts/RobotoMono || { echo -e "${boldRed}\nFalha ao instalar Roboto Mono.\n${reset}"; exit 1; }

# Atualizar o cache de fontes
echo -e "${boldGreen}\nAtualizando o cache das fontes...\n${reset}"
sudo fc-cache -f -v || { echo -e "${boldRed}\nFalha ao atualizar cache de fontes.\n${reset}"; exit 1; }

# Baixar e instalar o Google Chrome
echo -e "${boldGreen}\nBaixando e instalando Google Chrome...\n${reset}"
wget -q -O ~/Downloads/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
sudo apt install -y ~/Downloads/google-chrome-stable_current_amd64.deb && \
rm ~/Downloads/google-chrome-stable_current_amd64.deb || { echo -e "${boldRed}\nFalha ao instalar Google Chrome.\n${reset}"; exit 1; }

# Instalar pacotes npm (node.js)
echo -e "${boldGreen}\nInstalar pacotes npm (node.js):\n${reset}"
sudo npm install --global fast-cli puppeteer || { echo -e "${boldRed}\nFalha ao instalar pacotes npm (node.js).\n${reset}"; exit 1; }

#Instalando o logo-ls
echo -e "${boldGreen}\nInstalando o logo-ls:\n${reset}"
cd ~/Downloads
curl -OL https://github.com/Yash-Handa/logo-ls/releases/download/v1.3.7/logo-ls_amd64.deb
sudo dpkg -i ~/Downloads/logo-ls_amd64.deb || { echo -e "${boldRed}\nFalha ao instalar o logo-ls.\n${reset}"; exit 1; }
# Baixar configurações prontas do XFCE4 manager
echo -e "${boldGreen}\nBaixando configurações prontas do XFCE4 manager...\n${reset}"
git clone https://github.com/leodionisiolima/xubuntuConfig
cp -r ~/Downloads/xubuntuConfig/* ~/.config/xfce4/ || { echo -e "${boldRed}\nFalha ao copiar configurações do XFCE4 manager.\n${reset}"; exit 1; }

# Remapear a tecla Super para CAPS e remover o Ctrl direito
echo -e 'keycode 133 = Caps_Lock\nremove control = Control_R' > ~/.Xmodmap

cd ~ && source .bashrc
## Daqui pra cima ↑ está tudo consolidado, funcionando.
## Daqui pra baixo ↓ está tudo em teste

# Avisando que vai fazer backup do binário original do apt
echo -e "${boldGreen}Iniciando backup do binário original do apt...${reset}"
sudo mv /usr/bin/apt /usr/bin/apt.backup
if [ $? -eq 0 ]; then
    echo -e "${boldGreen}Backup do apt criado com sucesso.${reset}"
else
    echo -e "${boldRed}Falha ao criar backup do apt.${reset}"
    exit 1
fi

# Avisando que vai criar um link simbólico para nala como apt
echo -e "${boldGreen}Criando link simbólico de apt para nala...${reset}"
sudo ln -sf /usr/bin/nala /usr/bin/apt
if [ $? -eq 0 ]; then
    echo -e "${boldGreen}Link simbólico de apt para nala criado com sucesso.${reset}"
else
    echo -e "${boldRed}Falha ao criar link simbólico.${reset}"
    exit 1
fi

# Avisando que vai fazer backup do binário original do nano
echo -e "${boldGreen}Iniciando backup do binário original do nano...${reset}"
sudo mv /usr/bin/nano /usr/bin/nano.backup
if [ $? -eq 0 ]; then
    echo -e "${boldGreen}Backup do nano criado com sucesso.${reset}"
else
    echo -e "${boldRed}Falha ao criar backup do nano.${reset}"
    exit 1
fi

# Avisando que vai criar um link simbólico para micro como nano
echo -e "${boldGreen}Criando link simbólico de nano para micro...${reset}"
sudo ln -sf /usr/bin/micro /usr/bin/nano
if [ $? -eq 0 ]; then
    echo -e "${boldGreen}Link simbólico de nano para micro criado com sucesso.${reset}"
else
    echo -e "${boldRed}Falha ao criar link simbólico.${reset}"
    exit 1
fi


#Fim da configuração.
echo -e "${boldGreen}\nConfiguração concluída com sucesso, yay! ;D\n${reset}"
sleep 1
echo -e "${boldGreen}\nReiniciando computador...\n${reset}"
sleep 7
reboot
