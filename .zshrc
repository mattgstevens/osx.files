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


HEROKU_TOOLBELT=/usr/local/heroku/bin
HOMEBREW=/usr/local/bin
MYBIN=$HOME/bin
PATH=/usr/bin:/bin:/usr/sbin:/sbin
RBENV=$HOME/.rbenv/bin


export PATH="$HOMEBREW:$PATH:$HEROKU_TOOLBELT:$MYBIN:$GOPATH/bin"
export GOPATH

### ALIASES


# active projects
if [ -f $HOME/.projectsrc ]; then
	. $HOME/.projectsrc
fi

# backups
alias drop='$MYBIN/dropbox_as_backup.sh'
alias bwork="rsync -avuzb -h --delete-excluded --delete-after --exclude='.DS_Store' --exclude='*.ipc' --filter='dir-merge,-n .gitignore' ~/workspace/ '/Volumes/Bali Bull/mattgstevens/workspace/'"
alias bdrop="rsync -avuzb -h --delete-excluded --delete-after --exclude='.DS_Store' ~/Dropbox/ '/Volumes/Bali Bull/mattgstevens/Dropbox/'"
alias bproj="rsync -avuzb -h --delete-excluded --delete-after --exclude='.DS_Store' ~/Documents/project-notes/ '/Volumes/Bali Bull/mattgstevens/project-notes/'"

# certs
alias makecert='f() { openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout $1.key -out $1.crt -subj "/CN=$1" -days 3650};f'

# clojurescript
alias cljsm='lein clean && lein cljsbuild once min'

# databases
alias cpg='pg_ctl start -D /usr/local/var/postgres -l /usr/local/var/log/postgres/postgres.log'
alias cix='influx -config=/usr/local/etc/influxdb.conf'
alias cmemd='memcached -d'
alias cred='redis-server /usr/local/etc/redis.conf&'

# docker
alias dkclean='docker rmi $(docker images -q --filter "dangling=true")'
alias dkps='docker ps -a'
alias dkrm='docker rm $(docker ps -a -q)'
alias dkstop='docker stop $(docker ps -a -q)'
alias dkhalt='dkstop && dkrm'
# daemon
alias dkd='docker run --rm -d -P'
# interactive
alias dki='docker run --rm -it -P'

alias dkm='docker-machine'
alias dkmcreate='docker-machine create --driver virtualbox'
alias dkmenv='f() { eval "$(docker-machine env $1)" };f'

# find
alias y='ps -ef | grep $1'
alias wat='find . * | xargs grep --mmap -l'
# find . -name '*.jade' -print | xargs grep 'data-equalizer'
alias eh='LANG=; grep -ce $1 $2'

# git
alias ga='git add'
alias gh='git checkout'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch -p'
alias gl='git log'
alias gl0='git log --oneline'
alias gls='git show --stat --oneline'
alias gm='git merge --ff-only'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gs='git status -sb'
alias gsv='git stash save'
alias gsl='git stash list'
alias gsp='git stash pop'
alias grc='git rebase --continue'
alias gri='git rebase -i'
# rebase starting at commit hash $1 skip to commit $2 and continue
alias gro='git rebase --onto $1 $2 HEAD'
alias git-authors='git log | grep Author | sort | uniq'
alias git-contributors='git shortlog -s -n'
alias git-show-merges='ruby $MYBIN/git-show-merges.rb'
# http://gcc.gnu.org/ml/gcc/2007-12/msg00165.html
alias git-compress='git repack -a -d -f --depth=100 --window=100 --window-memory=1g'
alias git-files='git diff-tree --no-commit-id --name-status -r'
git-clean() {git filter-branch --index-filter 'git update-index --remove $1' $2..HEAD}

_git-ls () {
  for gitfile in $(git ls-tree -r --name-only HEAD);
  do
  echo "$( git log -1 --format="%ad %ae" --date=iso -- $gitfile ) $gitfile"
  done
}
git-ls () {
  _git-ls | column -t
}
git-lsr () {
  _git-ls | sort -r
}

# alias git-transfer='$MYBIN/git-transfer.sh'
# alias git-transfer='ruby $MYBIN/git-transfer.rb'

# go
alias gota='go test ./...'

# heroku
alias humatt='heroku accounts:set mattgstevens'
alias hrc='heroku run console'
alias henv='. $MYBIN/heroku_load_env.sh'

# helper
alias afk="date && pmset sleepnow"
alias conversion='ruby $MYBIN/conversions.rb'
alias hk='openssl rand $1 -hex'
alias lenv='source $MYBIN/load_env.sh'
alias mkd='mkdir -p "$1" && cd "$_"'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias sr='http-server --cors $1'
alias ytdl0='cd /Users/mattgstevens/workspace/learning/python/pafy/vids && source ../bin/activate'
alias tj='echo "# $(date +%Y%m%d)\n\n## today\n\n## soon\n\n## done" >> ~/Documents/journal/$(date +%Y%m%d).md && slime ~/Documents/journal'
# alias filecount="find . -type f | awk 'BEGIN {FS=\"/\";} {print $2;}' | sort | uniq -c | sort -rn | less"
# alias errorcount="find . -name '*.txt' | xargs cat | grep 'ERROR' | cut -d ':' -f 2 | sort | uniq -c"
# alias rename="ls | awk '/-shamsi/ {c=$0; gsub(\"-shamsi\", \"-mandala\"); system(\"mv \" c \" \" $0);}'"
# alias follow="tail -fn 1000 <file> | grep <filter>"

# list
alias duh='du -h'
alias la='ls -la'

# open
alias chrome='open -a "Google Chrome"'
alias slime='open -a "Sublime Text"'

# osx
alias trash='rm -rf $HOME/.Trash'

# redis
alias redkeys='$MYBIN/redis_key_size.sh'
alias reddel='function _reddel() { redis-cli KEYS "$1"* | xargs redis-cli DEL };_reddel'

# rbenv
alias rvc='rbenv version'
alias rvr='rbenv rehash'
alias rvl='rbenv versions'
alias rvu='rbenv local'

# rsync
alias rsync-copy="rsync -av --progress -h"
alias rsync-move="rsync -av --progress -h --remove-source-files"
alias rsync-update="rsync -avu --progress -h"
alias rsync-synchronize="rsync -avu --delete --progress -h"

# zsh
alias zshrc='slime ~/.zshrc'
alias zsr='source ~/.zshrc'


### SETUP


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source /usr/local/bin/virtualenvwrapper.sh

# torch
. /Users/mattgstevens/torch/install/bin/torch-activate

# pure prompt
PURE_PROMPT_SYMBOL=☯
fpath+=("/usr/local/share/zsh/site-functions")
autoload -U promptinit && promptinit
prompt pure
