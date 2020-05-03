#########################################################################
# Create some directories
#########################################################################
mkdir -p "${HOME}/tools/bin"
mkdir -p "${HOME}/sandbox"
mkdir -p "${HOME}/.fonts"

#########################################################################
# apt installs
#########################################################################
sudo apt install \
    build-essential \
    curl \
    exuberant-ctags \
    gawk \
    git \
    gsimplecal \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    llvm \
    make \
    python-openssl \
    sed \
    snapd \
    tk-dev \
    tmux \
    vim-nox \
    wget \
    xz-utils \
    zlib1g-dev \
    zsh

#########################################################################
# Clone prezto.
#########################################################################
if [[ "${ZPREZTODIR:-unset}" == "unset" ]]; then
       ZPREZTODIR="${ZDOTDIR:-$HOME}/.zprezto"
fi
if [[ ! -d "${ZPREZTODIR}" ]]; then
	git clone --recurse https://github.com/sorin-ionescu/prezto.git "${ZPREZTODIR}"
fi
# Updating prezto and submodules
cd "${ZPREZTODIR}"
git pull
git submodule update --init --recursive
git submodule sync --recursive
if [[ "${SHELL}" != "/bin/zsh" ]]; then
	# # Set zsh as default shell
	echo "Type your user password to alter your default shell to zsh"
	chsh -s /bin/zsh
fi

#########################################################################
# Clone prezto-contrib
#########################################################################
if [[ ! -d '${ZPRESTODIR}/contrib' ]]; then
	git clone --recurse https://github.com/belak/prezto-contrib.git "${ZPRESTODIR}/contrib"
fi
cd "${ZPRESTODIR}/contrib"
git submodule sync --recursive

# Install fzf
if [[ ! -d '${HOME}/.fzf' ]]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	bash ~/.fzf/install
fi

#########################################################################
# Install awesome-terminal-fonts
# Ref: https://github.com/gabrielelana/awesome-terminal-fonts.git
#########################################################################
# SRCDIR=$HOME/tools/awesome-terminal-fonts
# if [[ ! -d "${SRCDIR}" ]]; then
# 	git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts.git $SRCDIR
# fi
# cd $SRCDIR
# 
# git pull
# for F in `find build -maxdepth 1 -type f -printf "%f\n"`; do
# 	ln -s "$(pwd)/build/$F" "$HOME/.fonts/$F"
# done
# 
# fc-cache -fv $HOME/.fonts
# for F in `ls build/*.sh`; do
#  	sh $F
# done

cd ~/.fonts
if [[ ! -f "${HOME}/.fonts/Inconsolata.zip" ]]; then
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip
	unzip -o Inconsolata.zip
fi
fc-cache -fv

#########################################################################
# Loading gnome-terminal DiRaOL Profile
#########################################################################
dconf load /org/gnome/terminal/ < $HOME/.homesick/repos/dotfiles/gnome_terminal_DiRaOL_settings.txt

#########################################################################
# Installing themes for gnome-terminal (to use gruvbox)
# This is disabled because the theme was already applied to the gnome
# settings above, so, loading it already do the job.
#########################################################################
# SRCDIR=$HOME/sandbox/gnome-terminal-colors
# git clone https://github.com/metalelf0/gnome-terminal-colors.git $SRCDIR 
# cd $SRCDIR
# sh install.sh
# rm -rf $SRCDIR

#########################################################################
# Install powerline-patched-fonts
# Ref: https://github.com/powerline/fonts
#########################################################################
# SRCDIR=$HOME/sandbox/powerline-fonts
# git clone https://github.com/powerline/fonts.git --depth=1 $SRCDIR 
# cd $SRCDIR 
# sh install.sh
# rm -rf $SRCDIR

#########################################################################
# Installing syntax checkers
#########################################################################
# cd $HOME
# pip3 install pylint

#########################################################################
# Tmux plugin manager 
#########################################################################
if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi
#########################################################################
# VIM setup - my spf13 fork
#########################################################################
# sh <(curl https://raw.githubusercontent.com/diraol/spf13-vim/3.0/bootstrap.sh -L)
# Vim pt_br spell
if [[ ! -d "${HOME}/.EverVim" ]]; then
	git clone https://github.com/LER0ever/EverVim "${HOME}/.EverVim"
	cd "${HOME}/.EverVim"
	sh Boot-EverVim.sh
fi
if [[ ! -d "${HOME}/.vim/spell" ]]; then
	mkdir -p $HOME/.vim/spell
	cp $HOME/.homesick/repos/dotfiles/spell/pt.utf-8.spl $HOME/.vim/spell/
fi

#########################################################################
# i3status helpers
#########################################################################
# git clone https://github.com/mikereinhold/i3status-helpers.git ~/.i3/status-helpers

#########################################################################
# Python env setup
#########################################################################
# deps: 
# pyenv (using virtualenvwrapper)
if [[ ! -d "${HOME}/.pyenv" ]]; then
	bash <(curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer)
	# Loading env variables to keep installation
	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

#########################################################################
# Enable ssh-agent service
#########################################################################
systemctl --user enable ssh-agent.service


sudo snap install keepassxc
sudo snap install telegram-desktop
