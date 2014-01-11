# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails ruby rake)

source $ZSH/oh-my-zsh.sh


### EXPORTS


PATH=/usr/bin:/bin:/usr/sbin:/sbin

MYBIN=/Users/mattgstevens/bin
HOMEBREW=/usr/local/bin
NPM=/usr/local/share/npm/bin

export PATH="$HOMEBREW:$PATH:$NPM:$MYBIN"

if [ -f $HOME/.rvm/scripts/rvm ]; then
       . $HOME/.rvm/scripts/rvm
fi


### ALIASES


# active projects
. $HOME/.projectsrc

# backups
alias drop='dropbox_as_backup.sh'

# heroku
alias huclear='heroku accounts:set clearfit'
alias humatt='heroku accounts:set mattgstevens'
alias hrc='heroku run console'

# helper
alias lenv='source $MYBIN/load_env.sh'

# git
alias ga='git add'
alias gh='git checkout'
alias gc='git commit'
alias gd='git difftool'
alias gf='git fetch'
alias gl='git log'
alias gm'git merge'
alias gp='git push'
alias gs='git status'
alias gsv='git stash save'
alias gsl='git stash list'
alias gsp='git stash pop'
alias git-authors='git log | grep Author | sort | uniq'
alias git-show-merges='ruby $MYBIN/git-show-merges.rb'

# find
alias y='ps -ef | grep $1'
alias wat='find . * | xargs grep --mmap -l'
alias eh='LANG=; grep -ce $1 $2'

# list
alias duh='du -sh'
alias ll='ls -l'
alias la='ls -la'

# open
alias diffmerge='diffmerge.sh'
alias chrome='open -a "Google Chrome"'
alias slime='open -a "Sublime Text 2"'
alias pentaho='pentaho.sh'

# postgres
alias cpg='pg_ctl start -D /usr/local/var/postgres'

# redis
alias cred='redis-server /usr/local/etc/redis.conf'

# rvm
alias gems='slime `rvm gemdir`'
alias rubies='slime $MY_RUBY_HOME'
alias rvu='rvm use .rvmrc || rvm use .ruby-version'
alias rvc='rvm current'

# zeus
alias zss='zeus start'
alias zs='zeus server'
alias zc='zeus console'
alias zr='zeus rake'

# zsh
alias zsr='source ~/.zshrc'
