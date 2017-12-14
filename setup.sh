!/usr/bin/env bash
if ! type "sudo" > /dev/null; then
  alias sudo='su -c"$*"'
  echo "You do not have 'sudo' installed, so I'll ask your password in every 'sudo' step."
fi

# sox is for 'play' command to be used with irssi irc client
echo "01 - Installing basic packages (ruby, git, vim, irc, rdoc, tmux, pip)"
sudo aptitude install -y ruby rdoc irb git vim-nox python-pip python-pip3 tmux exuberant-ctags sox feh irssi keepass2 chromium zsh

echo "02 - Changin default shell to zsh"
chsh -s $(which zsh) $USER

echo "03 - Downloading RubyGems to ~/tools/"
mkdir -p ~/tools
cd ~/tools
wget https://rubygems.org/rubygems/rubygems-2.6.6.tgz

echo "04 - Extracting RubyGems package"
tar xzf rubygems-2.6.6.tgz

echo "05 - Installing RubyGems"
cd rubygems-2.6.6
sudo ruby setup.rb all

echo "06 - Updating rubygems"
sudo gem update --system

echo "07 - Removing rubygems installer files"
cd ..
rm -rf rubygems*

echo "08 - Installing homesick"
sudo gem install homesick

echo "09 - Cloning my dotfiles repo"
homesick clone https://github.com/diraol/dotfiles.git

echo "10 - Updating homesick submodules"
cd ~/.homesick/repos/dotfiles/
git checkout personal
git submodule update --init --recursive
homesick symlink dotfiles

# Installing Powerline
echo "11 - Installing powerline"
sudo pip install powerline-status
sudo pip3 install powerline-status

echo "12 - Installing virtualenv tools"
# Installing virtualenv requirements
sudo pip install virtualenv virtualenvwrapper
sudo pip3 install virtualenv virtualenvwrapper

echo "13 - Installing vim plugins with Bundle/Vundle"
vim +BundleInstall +BundleClean +qall

echo "14 - Creating user context java directories"
mkdir -p ~/.java/.systemPrefs
mkdir ~/.java/.userPrefs
chmod -R 755 ~/.java
