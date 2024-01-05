#!/bin/bash
# Automated Environment Setup

dotpath=$(pwd)

################################################################################
# Initial Configuration

# Create SSH Key-pair
if [ -f '~/.ssh/id_ed25519' ]
then
    echo "Input SSH Key Description: "
    read keydesc
    echo "Generating keypair."
    ssh-keygen -t ed25519 -C "$keydesc"
fi

if [ -f /snap/ ]
then
# Disable and Purge Snapd
sudo cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

sudo snap remove $(snap list | awk '!/^Name|^core/ {print $1}')
sudo snap remove --purge -y snapd gnome-software-plugin-snap

fi


# Add Dockers official GPG key
if [ ! -f "/etc/apt/keyrings/docker.gpg" ]
then
	sudo apt-get install ca-certificates curl gnupg
	sudo install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg

	# Add the repository to Apt sources:
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# Setup external repositories
# Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable

# Install useful packages

PACKAGES=(
    tmux build-essential powerline zsh docker-ce docker-ce-cli containerd.io
    docker-buildx-plugin docker-compose-plugin
)

sudo apt update
sudo apt install $PACKAGES

################################################################################
# Package Specific Setup

ln -s $dotpath/.tmux.conf $HOME/.tmux.conf

# ZSH

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/OhMyZsh-full-autoupdate
git clone https://github.com/rupa/z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/powerlevel10k

ln -s $dotpath/.zshrc ~/.zshrc
ln -s $dotpath/.zsh_aliases ~/.zsh_aliases

# VIM
mkdir ~/.vim
mkdir ~/.vim/{misc,undo}
ln -s $dotpath/.vimrc ~/.vimrc

NVIM_CONFIG=~/.config/nvim
ln -s $dotpath/.config/nvim/coc-settings.json $NVIM_CONFIG/
ln -s $dotpath/.config/nvim/init.vim $NVIM_CONFIG/

nvim +PlugInstall
