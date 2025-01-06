#!/bin/bash

echo "Atualizando o sistema..."
apt update && apt upgrade -y

echo "Atualizando o kernel..."
apt install linux-image-amd64 linux-headers-amd64 -t bookworm-backports -y

echo "Instalando o firmware do processador..."
apt install intel-microcode -y

echo "Removendo pacotes desnecessários..."
apt remove pidgin gnome-games --purge -y && apt autoremove -y

echo "Configurando o sources.list..."
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
EOF
apt update

echo "Alterando a swappiness..."
echo "vm.swappiness=10" >> /etc/sysctl.conf && sysctl -p

echo "Adicionando usuário ao grupo sudo..."
apt install sudo -y
read -p "Digite o nome do usuário para adicionar ao grupo sudo: " USUARIO
adduser "$USUARIO" sudo

echo "Instalando fontes da Microsoft..."
apt install ttf-mscorefonts-installer -y && fc-cache -f -v

echo "Ativando o firewall..."
apt install ufw gufw -y
ufw enable

echo "Instalando ferramentas de compactação..."
apt install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip -y

echo "Configurando Flatpak..."
apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Removendo LibreOffice e Firefox ESR..."
apt remove libreoffice* firefox-esr* -y

echo "Instalando e configurando Git..."
apt install git -y
read -p "Digite o nome de usuário para o Git: " GIT_USER
read -p "Digite o e-mail para o Git: " GIT_EMAIL
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"

echo "Gerando chave SSH..."
ssh-keygen -t ed25519 -C "$GIT_EMAIL"

echo "Instalando Java..."
apt install openjdk-17-jdk openjdk-17-jre -y
echo 'JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"' >> /etc/environment && source /etc/environment

echo "Instalando Ruby..."
apt install ruby-full -y

echo "Instalando o Vagrant..."
wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install vagrant

echo "Instalando Docker..."
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

read -p "Nome do usuário para adicionar ao grupo: " USER
usermod -aG docker "$USER"

echo "Instalando programas via Flatpak..."
flatpak install flathub com.google.Chrome -y
flatpak install flathub org.mozilla.firefox -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub com.visualstudio.code -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub com.anydesk.Anydesk -y
flatpak install flathub org.flameshot.Flameshot -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub org.virt_manager.virt-manager -y

echo "Instalando o tema Papirus..."
echo "deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main" > /etc/apt/sources.list.d/papirus-ppa.list
wget -qO /etc/apt/trusted.gpg.d/papirus-ppa.asc 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F'
apt update
apt install papirus-icon-theme -y

echo "Configuração concluída!"
