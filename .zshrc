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

export PATH="$HOMEBREW:$PATH:$NPM"

if [ -f $HOME/.rvm/scripts/rvm ]; then
  . $HOME/.rvm/scripts/rvm
fi


### ALIASES


# active projects
. $HOME/.projectsrc

# backups
alias drop='$MYBIN/dropbox_as_backup.sh'

# databases
alias cpg='pg_ctl start -D /usr/local/var/postgres -l /usr/local/var/log/postgres/postgres.log'
alias cred='redis-server /usr/local/etc/redis.conf'
alias cix='influxdb -config=/usr/local/etc/influxdb.conf'
alias cmemd='/usr/local/opt/memcached/bin/memcached'

# heroku
alias huclear='heroku accounts:set clearfit'
alias humatt='heroku accounts:set mattgstevens'
alias hrc='heroku run console'

# helper
alias convert='ruby $MYBIN/conversions.rb'
alias devup='$MYBIN/update_dev_tools.sh'
alias lenv='source $MYBIN/load_env.sh'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# git
alias git=hub
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
alias grc='git rebase --continue'
alias gri='git rebase -i'
alias git-authors='git log | grep Author | sort | uniq'
alias git-show-merges='ruby $MYBIN/git-show-merges.rb'
alias git-compress='git repack -a -d' # http://gcc.gnu.org/ml/gcc/2007-12/msg00165.html

# grunt
alias grd='grunt default'
alias grw='grunt watch'

# find
alias y='ps -ef | grep $1'
alias wat='find . * | xargs grep --mmap -l'
alias eh='LANG=; grep -ce $1 $2'

# list
alias duh='du -h'
alias ll='ls -l'
alias la='ls -la'

# open
alias diffmerge='diffmerge.sh'
alias chrome='open -a "Google Chrome"'
alias slime='open -a "Sublime Text 2"'
alias pentaho='pentaho.sh'

# redis
alias redkeys='$MYBIN/redis_key_size.sh'

# rvm
alias gems='slime `rvm gemdir`'
alias rubies='slime $MY_RUBY_HOME'
alias rvu='rvm use'
alias rvc='rvm current'

# zeus
alias zss='zeus start'
alias zs='zeus server'
alias zc='zeus console'
alias zr='zeus rake'

# zsh
alias zsr='source ~/.zshrc'
