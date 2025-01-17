## Pós-Configuração do Debian 12
Descrição
Este script automatiza a configuração inicial do Debian 12 com a interface Gnome, realizando tarefas como atualização de pacotes, instalação de softwares essenciais, ajustes de performance e personalização do ambiente de trabalho.

### Recursos
* Atualização do sistema e do kernel.
* Remoção de aplicativos desnecessários (como jogos e Pidgin).
* Configuração de repositórios oficiais (sources.list).
* Ajuste da swappiness para melhorar o desempenho.
* Instalação de fontes da Microsoft.
* Ativação e configuração do firewall.
* Instalação de ferramentas de compactação e descompactação.
* Configuração do Flatpak e instalação de aplicativos úteis.
* Personalização com tema de ícones Papirus.
* Configuração de Git, Java, Ruby, Vagrant e Docker.

### Requisitos
* Sistema operacional Debian 12 (Bookworm).
* Acesso root para executar o script.
* Conexão com a internet.

### Como Usar
1. Clone o Repositório
   ```
   git clone git@github.com:joaolucasrossato/post-install-debian.git
   cd post-install-debian
   ```
2. Deixe o script executável.
   ```
   chmod +x post-install.sh
   ```
3. Execute o script como root:
   ```
   sudo ./post-install.sh
   ```                    

### Pacotes Instalados

* Atualizações do sistema: linux-image-amd64, linux-headers-amd64, intel-microcode.
* Ferramentas essenciais: ufw, flatpak, arc, p7zip-full, git, openjdk-17-jdk, ruby-full, docker, etc.
* Aplicativos via Flatpak: Google Chrome, Firefox, Discord, Spotify, VLC, Visual Studio Code, Flameshot, e mais.
  
### Personalização
Tema de ícones Papirus:
Instalado e configurado automaticamente para melhorar a estética do ambiente gráfico.



