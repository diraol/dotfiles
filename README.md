dotfiles
========

Dot files based on "Homesick"

To install and use this configurations, you need to install ruby/rubygems first:

    # Install Ruby:
    sudo aptitude install ruby rdoc irb git
    #
    # Download the latest rubygems from: http://rubyforge.org/projects/rubygems/
    #       In my case was rubygems-1.8.25.tgz
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
