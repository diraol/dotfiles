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
sudo apt install vim-nox gsimplecal -y

#########################################################################
# Clone prezto.
#########################################################################
if [ !-d "$HOME/.zpresto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
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
if [ !-d "$HOME/.zprezto-contrib" ]
  git clone --recursive https://github.com/belak/prezto-contrib.git "$HOME/.zprezto-contrib"
fi

#########################################################################
# Install awesome-terminal-fonts
# Ref: https://github.com/gabrielelana/awesome-terminal-fonts.git
#########################################################################
SRCDIR=$HOME/tools/awesome-terminal-fonts
if [ !-d $SRCDIR ]; then
  git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts.git $SRCDIR
fi
cd $SRCDIR
for F in `find build -maxdepth 1 -type f -printf "%f\n"`; do
  if [ !-f "$HOME/.fonts/$F" ]; then
    ln -s "build/$F" "$HOME/.fonts/$F"
  fi
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
if [ !-d $SRCDIR ]; then
  git clone https://github.com/powerline/fonts.git --depth=1 $SRCDIR
fi
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
if [ -d $HOME/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

#########################################################################
# i3status helpers
#########################################################################
mkdir -p $HOME/.i3
if [ !-d $HOME/.i3/status-helpers ]; then
  git clone https://github.com/mikereinhold/i3status-helpers.git $HOME/.i3/status-helpers
fi

#########################################################################
# Python env setup
#########################################################################
LATEST_PYTHON="3.6.3"
# deps:
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev
export PYTHON_CONFIGURE_OPTS="--enable-shared"
# pyenv (using virtualenvwrapper)
if [ !-d $HOME/.pyenv ]; then
  bash <(curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer)
fi
# Loading env variables to keep installation
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# pyenv-virtualenv
if [ !-d $(pyenv root)/plugins/pyenv-virtualenv ];  then
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi
# pyenv-virtualenvwrapper
if [ !-d $(pyenv root)/plugins/pyenv-virtualenvwrapper ];  then
  git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
fi
pyenv install $LATEST_PYTHON
pyenv global $LATEST_PYTHON

#########################################################################
# VIM setup - my spf13 fork
#########################################################################
if [ !-d $HOME/.spf13-vim ]; then
  git clone https://github.com/diraol/spf13-vim $HOME/.spf13-vim
fi
cd $HOME/.spf13-vim
git submodule update --init --recursive
SRCDIR=$HOME/.spf13-vim
rm -rf $HOME/.vim $HOME/.vimrc $HOME/.vimrc.before $HOME/.vimrc.bundles
ln -s $SRCDIR/.vim $HOME/.vim
ln -s $SRCDIR/.vimrc $HOME/.vimrc
ln -s $SRCDIR/.vimrc.before $HOME/.vimrc.before
ln -s $SRCDIR/.vimrc.bundles $HOME/.vimrc.bundles

# Vim pt_br spell
mkdir -p $HOME/.vim/spell
cp $HOME/.homesick/repos/dotfiles/vimspell/pt.utf-8.spl $HOME/.vim/spell/

local system_shell="$SHELL"
export SHELL='/bin/sh'
vim -u "$SRCDIR/.vimrc.bundles.default" \
    "+set nomore" \
    "+PluginInstall!" \
    "+PluginClean" \
    "+qall"
export SHELL="$system_shell"

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
