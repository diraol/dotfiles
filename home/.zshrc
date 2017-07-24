
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# Path to your oh-my-zsh installation directory.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# Powerline theme installed from jeremyFreeAgent/oh-my-zsh-powerline-theme
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME='bureau'

# # Powerline theme options.
# POWERLINE_HIDE_USER_NAME="true"
# POWERLINE_HIDE_HOST_NAME="true"
# POWERLINE_NO_BLANK_LINE="true"
# POWERLINE_SHOW_GIT_ON_RIGHT="true"
# POWERLINE_PATH="short"
# POWERLINE_CUSTOM_CURRENT_PATH="%3~"
# POWERLINE_DETECT_SSH="true"
# ZSH_THEME="powerline"

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs virtualenv time)

# Remove it?
POWERLEVEL9K_MODE='awesome-fontconfig'

# POWERLEVEL9K_MODE='awesome-fontconfig'
ZSH_THEME="powerlevel9k"


# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(cp ssh-agent systemd debian colorize tmux git git-extras autopep8 github jsontools pep8 python pip virtualenvwrapper tmux zsh-navigation-tools)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
# export MANPATH="/usr/local/man:$MANPATH"
zstyle ':omz:module:tmux' auto-start 'yes'
ZSH_TMUX_AUTOSTART="false"
ZSH_TMUX_AUTOCONNECT='false'

# OH MY ZSH! from robbyrussell/oh-my-zsh.
source $ZSH/oh-my-zsh.sh
# Aliases
alias zshconfig="vim ~/.zshrc"

# Other exports
export VIRTUAL_ENV_DISABLE_PROMPT=1 # Let Virtualenv prompt show up in the zsh theme.
#export PYTHONDOCS=/usr/share/doc/python2/html/ # Needed for the python2-docs package.

# Get the keychain running.
#eval `keychain --eval --agents ssh id_rsa --quiet`

# Tmuxinator tab names are overriden by zsh auto title.
export DISABLE_AUTO_TITLE='true'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="source ~/.zshrc"
# alias ohmyzsh="source ~/.oh-my-zsh"

zstyle :omz:plugins:ssh-agent agent-forwarding on

source ~/.fonts/*.sh
source ~/.diraol/rc
