CURDIR=$(pwd)
#########################################################################
# Create some directories
#########################################################################
mkdir -p $HOME/tools/bin
mkdir -p $HOME/sandbox
mkdir -p $HOME/.fonts

#########################################################################
# apt installs
#########################################################################
sudo apt install vim-nox gsimplecal

#########################################################################
# Clone prezto.
#########################################################################
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# Updating prezto and submodules
cd $ZPREZTODIR
git pull
git submodule update --init --recursive
# Set zsh as default shell
echo "Type your user password to alter your default shell to zsh"
chsh -s /bin/zsh

#########################################################################
# Clone prezto-contrib
#########################################################################
git clone --recursive https://github.com/belak/prezto-contrib.git "$HOME/.zprezto-contrib"

#########################################################################
# Install awesome-terminal-fonts
# Ref: https://github.com/gabrielelana/awesome-terminal-fonts.git
#########################################################################
SRCDIR=$HOME/tools/awesome-terminal-fonts
git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts.git $SRCDIR 
cd $SRCDIR
for F in `find build -maxdepth 1 -type f -printf "%f\n"`; do
  ln -s "build/$F" "$HOME/.fonts/$F"
done
fc-cache -fv $HOME/.fonts
for F in `ls build/*.sh`; do
  sh $F
done

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
SRCDIR=$HOME/sandbox/powerline-fonts
git clone https://github.com/powerline/fonts.git --depth=1 $SRCDIR 
cd $SRCDIR 
sh install.sh
rm -rf $SRCDIR

#########################################################################
# Installing syntax checkers
#########################################################################
cd $HOME
pip3 install pylint

#########################################################################
# Tmux plugin manager 
#########################################################################
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

#########################################################################
# VIM setup - my spf13 fork
#########################################################################
sh <(curl https://raw.githubusercontent.com/diraol/spf13-vim/3.0/bootstrap.sh -L)
# Vim pt_br spell
mkdir -p $HOME/.vim/spell
cp $HOME/.homesick/repos/dotfiles/spell/pt.utf-8.spl $HOME/.vim/spell/

#########################################################################
# i3status helpers
#########################################################################
git clone https://github.com/mikereinhold/i3status-helpers.git ~/.i3/status-helpers

#########################################################################
# Python env setup
#########################################################################
# deps: 
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev
# pyenv (using virtualenvwrapper)
bash <(curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer)
# Loading env variables to keep installation
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
# pyenv-virtualenvwrapper
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

# ########################################################################
# Enable ssh-agent service
#########################################################################
systemctl --user enable ssh-agent.service

# ############################################################################
# Setup scala/sbt
##############################################################################
sudo apt install scala
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt update
sudo apt install sbt
