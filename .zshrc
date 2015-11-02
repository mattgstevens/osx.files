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
plugins=(git ruby)

source $ZSH/oh-my-zsh.sh


### EXPORTS


MYBIN=$HOME/bin
HEROKU_TOOLBELT=/usr/local/heroku/bin
HOMEBREW=/usr/local/bin
PATH=/usr/bin:/bin:/usr/sbin:/sbin
RBENV=$HOME/.rbenv/bin

export PATH="$HOMEBREW:$PATH:$HEROKU_TOOLBELT:$MYBIN"


### ALIASES


# active projects
if [ -f $HOME/.projectsrc ]; then
	. $HOME/.projectsrc
fi

# backups
alias drop='$MYBIN/dropbox_as_backup.sh'

# databases
alias cpg='pg_ctl start -D /usr/local/var/postgres -l /usr/local/var/log/postgres/postgres.log'
alias cix='influxdb -config=/usr/local/etc/influxdb.conf'
alias cmemd='memcached -d'
alias cred='redis-server /usr/local/etc/redis.conf&'

# docker
#alias dock-con='docker rm $(docker ps -a | grep Exited | awk '{print $1}')'
#alias dock-img='docker rmi $(docker images -q --filter "dangling=true")'
#alias dock-stop='docker stop $(docker ps -a | grep $1 | awk '{print $1}')'

# heroku
alias huclear='heroku accounts:set clearfit'
alias humatt='heroku accounts:set mattgstevens'
alias hrc='heroku run console'
alias henv='. $MYBIN/heroku_load_env.sh'

# helper
alias afk="date && pmset sleepnow"
alias conversion='ruby $MYBIN/conversions.rb'
alias hk='openssl rand $1 -hex'
alias lenv='source $MYBIN/load_env.sh'
alias mkd='mkdir -p "${1}" && cd "$_"'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias sr='http-server -p 4545 $1'

# alias filecount="find . -type f | awk 'BEGIN {FS=\"/\";} {print $2;}' | sort | uniq -c | sort -rn | less"
# alias errorcount="find . -name '*.txt' | xargs cat | grep 'ERROR' | cut -d ':' -f 2 | sort | uniq -c"

# git
alias ga='git add'
alias gh='git checkout'
alias gc='git commit'
alias gd='git difftool'
alias gf='git fetch -p'
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
# http://gcc.gnu.org/ml/gcc/2007-12/msg00165.html
alias git-compress='git repack -a -d'
alias git-files='git diff-tree --no-commit-id --name-status -r'
git-clean() {git filter-branch --index-filter 'git update-index --remove $1' $2..HEAD}

# alias git-transfer='$MYBIN/git-transfer.sh'
# alias gxfr='ruby $MYBIN/git-transfer.rb'

# find
alias y='ps -ef | grep $1'
alias wat='find . * | xargs grep --mmap -l'
# find . -name '*.jade' -print | xargs grep 'data-equalizer'
alias eh='LANG=; grep -ce $1 $2'

# list
alias duh='du -h'
alias ll='ls -l'
alias la='ls -la'

# open
alias chrome='open -a "Google Chrome"'
alias slime='open -a "Sublime Text"'

# osx
alias trash='rm -rf $HOME/.Trash'

# redis
alias redkeys='$MYBIN/redis_key_size.sh'

# rbenv
alias rvc='rbenv version'
alias rvr='rbenv rehash'
alias rvl='rbenv versions'
alias rvu='rbenv local'

# zsh
alias zsr='source ~/.zshrc'


### SETUP


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
