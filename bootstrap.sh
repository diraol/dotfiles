!/usr/bin/env bash
if ! type "sudo" > /dev/null; then
  alias sudo='su -c"$*"'
  echo "You do not have 'sudo' installed, so I'll ask your password in every 'sudo' step."
fi

echo "01 - Installing basic packages (ruby, git, vim, irc, rdoc, tmux, pip)"
sudo aptitude install -y ruby rdoc irb git vim python-pip python-pip3 tmux

echo "02 - Downloading RubyGems to ~/tools/"
mkdir -p ~/tools
cd ~/tools
wget https://rubygems.org/rubygems/rubygems-2.6.6.tgz

echo "03 - Extracting RubyGems package"
tar xzf rubygems-2.3.0.tgz

echo "04 - Installing RubyGems"
cd rubygems-2.3.0
sudo ruby setup.rb all

echo "05 - Updating rubygems"
sudo gem update --system

echo "06 - Removing rubygems installer files"
cd ..
rm -rf rubygems*

echo "07 - Installing homesick"
sudo gem install homesick

echo "08 - Cloning my dotfiles repo"
homesick clone https://github.com/diraol/dotfiles.git

echo "09 - Installing ctags"
sudo apt-get install exuberant-ctags -y

echo "10 - Updating homesick submodules"
cd ~/.homesick/repos/dotfiles/
git submodule update --init --recursive
homesick symlink dotfiles

echo "11 - Installing vim plugins with Bundle/Vundle"
vim +BundleInstall +BundleClean +qall

# Installing Powerline
echo "12 - Installing powerline"
sudo pip install powerline-status
sudo pip3 install powerline-status
