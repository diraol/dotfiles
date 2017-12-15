dotfiles
========

Dot files with on "Homesick" - my deploy for EasyTaxi work notebook

Install homesick (using ruby gem) and make sure to have git installed.
Then:

# Clone homesick repo
``homesick clone git@github.com:diraol/dotfiles.git``

# Checkout the correct branch
``homesick exec dotfiles git checkout easy``

# "Activate" the dotfiles (create symlinks) 
``homesick symlink dotfiles``

# Run bootstrap script
``homesick rc dotfiles``
