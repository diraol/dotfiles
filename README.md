dotfiles
========

Dot files with on "Homesick"

To install run the following commands on the command-line:

    mkdir $HOME/temp
    wget https://github.com/diraol/dotfiles/blob/homesick/bootstrap.sh
    chmod +x bootstrap.sh
    ./bootstrap.sh


To manually install and use this configurations, you need to install
ruby/rubygems first:

    # Install Ruby:
    sudo aptitude install ruby rdoc irb git
    #
    # Download the latest rubygems from: https://rubygems.org/pages/download
    #       In my case was rubygems-2.3.0.tgz
    #
    # Unpack it
    tar xzf rubygems-1.8.25.tgz
    #
    # Enter the folder:
    cd rubygems-1.8.25
    #
    # Install it:
    sudo ruby setup.rb all
    #
    # To install homesick
    sudo gem install homesick
    #
    # To clone a homesick repos
    homesick clone git@github.com:diraol/dotfiles.git
    #
    # To list all homesick repositories avaliable
    homesick list
    # p.ex.: dotfiles  git@github.com:diraol/dotfiles.git
    #
    # To "activate" a repository
    # homesick symlink dotfiles
    #
    # or use the bootstrap function
    ~/.homesick/repos/dotfiles/bootstrap.sh
