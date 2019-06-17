#
# Init
#

# plan is to move to setup like
# https://github.com/caarlos0/dotfiles
export DOTFILES="$HOME/dotfiles"

# all of our zsh files
typeset -U config_files
config_files=($DOTFILES/*/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}; do
  echo "$file"
  source "$file"
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}; do
  source "$file"
done

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}; do
  source "$file"
done

#
# Antibody
#

# https://getantibody.github.io/usage/#static-loading
# use `antir` to generate this file
source ~/.zsh_plugins.sh

#
# PATH
#

HOMEBREW=/usr/local/bin
GCLOUD=$HOME/google-cloud-sdk/bin
MYBIN=$HOME/bin
PATH=/usr/bin:/bin:/usr/sbin:/sbin
RUST=$HOME/.cargo/bin
STACK=$HOME/.local/bin


export PATH="$HOMEBREW:$GCLOUD:$PATH:$MYBIN:$RUST:$STACK"

#
# ALIASES
#

# active projects
if [ -f $HOME/.private-env ]; then
	. $HOME/.private-env
fi

#
# antibody
#

# https://getantibody.github.io/usage/#static-loading
alias antir='antibody bundle < ~/dotfiles/antibody/bundles.txt > ~/.zsh_plugins.sh'
alias antiup='antibody update'

#
# backups
#

alias ball='f() {
echo "bwork"; time bwork;
echo "bdrop"; time bdrop;
echo "bdocs"; time bdocs;
echo "bssh";  time bssh;
echo "bbackgrounds";  time bbackgrounds;
echo "bmusic";  time bmusic;
echo "bmovies";  time bmovies;
echo "bdesktop";  time bdesktop;
echo "bhome";  time bhome;
echo "bsublime";  time bsublime;
};f'
alias bwork="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' --exclude='*.ipc' --filter='dir-merge,-n .gitignore' ~/workspace/ '$BACKUP_DIR/workspace/'"
alias bdrop="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Dropbox/ '$BACKUP_DIR/Dropbox/'"
alias bdocs="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Documents/ '$BACKUP_DIR/Documents/'"
alias bssh="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/.ssh '$BACKUP_DIR/.ssh/'"
alias bbackgrounds="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Pictures/Backgrounds '$BACKUP_DIR/Backgrounds/'"
alias bmusic="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Music/ '$BACKUP_DIR/Music/'"
alias bmovies="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Movies/ '$BACKUP_DIR/Movies/'"
alias bdesktop="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Desktop/ '$BACKUP_DIR/Desktop/'"
alias bhome="cp -R ~/.private-env ~/.zsh_history ~/.private '$BACKUP_DIR/HOME/'"
alias bsublime="cp -R ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/ $BACKUP_DIR/Application\ Support/Sublime\ Text\ 3/Packages/User/"

#
# brew
#

# removes old version of packages and their downloads; flag "s" removes downloads for latest packages
alias brewclean='brew cleanup -s'

#
# clojurescript
#

alias cljsm='lein clean && lein cljsbuild once min'
alias figboot='rlwrap lein figwheel dev'

#
# docker
#

# this was useful for an older version of docker, pre Docker.app, when using docker-machine
alias dkmac='f() {
  unset DOCKER_TLS_VERIFY
  unset DOCKER_CERT_PATH
  unset DOCKER_MACHINE_NAME
  unset DOCKER_HOST
};f'
alias dkclean='docker rmi $(docker images -q --filter "dangling=true")'
alias dkps='docker ps -a'
alias dkrm='docker rm $(docker ps -a -q)'
alias dkstop='docker stop $(docker ps -a -q)'
alias dkhalt='dkstop && dkrm'
# daemon
alias dkd='docker run --rm -d -P'
# shell (input is docker image to run)
alias dks='docker run -it $1 /bin/sh'
# attach (input is container ID)
alias dka='docker exec -it $1 /bin/sh'
# build
alias dkb='docker build . -t `echo $(basename $PWD):$(git rev-parse --short HEAD)`'

# special hostname for Docker for mac
# POSTGRES_HOST=docker.for.mac.host.internal

#
# docker-machine
#

alias dkm='docker-machine'
alias dkmcreate='docker-machine create --driver virtualbox'
alias dkmcreatedi='docker-machine create --driver digitalocean --digitalocean-access-token'
alias dkmenv='f() { eval "$(docker-machine env $1)" };f'
alias dkmboot='f() { dkm start $1 ; dkmenv $1 };f'

#
# find
#

alias y='ps -ef | grep $1'
alias wat='f() { find . -name $1 | xargs grep --mmap -l $2 }'
alias eh='LANG=; grep -ce $1 $2'
#
# git
#

# there is always more
# https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
alias ga='git add'
alias gb='git branch'
alias gbr='git branch --remote'
alias gh='git checkout'
alias gc='git commit'
alias gd='git diff -w'
alias gdc='git diff --cached'
alias gf='git fetch -p'
alias gl='git log --show-signature'
alias gl0='git log --oneline'
alias gls='git show --stat --oneline'
alias gm='git merge --ff-only'
alias gp='git push --follow-tags'
alias gpf='git push --force-with-lease'
alias gs='git status -sb'
alias gsv='git stash save'
alias gsl='git stash list'
alias gsp='git stash pop'
alias grc='git rebase --continue'
alias gri='git rebase -i'
# rebase starting at commit hash $1 skip to commit $2 and continue
alias gro='git rebase --onto $1 $2 HEAD'
alias git-authors='git log --no-merges | grep Author | sort | uniq'
alias git-contributors='git shortlog -s -n'
alias git-recent='git for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias git-overview='git log --all --since="2 weeks" --no-merges'
# http://gcc.gnu.org/ml/gcc/2007-12/msg00165.html
alias git-compress='git repack -a -d -f --depth=100 --window=100 --window-memory=1g'
alias git-files='git diff-tree --no-commit-id --name-status -r'
git-clean() { git filter-branch --index-filter 'git rm --cached --ignore-unmatch $1' HEAD }

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

#
# github
#

github-user () { curl -i https://api.github.com/users/$1 }

#
# gpg
#

alias gpgls='gpg --list-secret-keys --keyid-format LONG'
# use the "sec" part of the above command for the desired key to export
alias gpgex='gpg --armor --export $1'

#
# go
#

alias gota='go test ./...'
alias gopath='GOPATH=`pwd`'

#
# helper
#

alias ..='cd ..'
alias afk="date && pmset sleepnow"
alias conversion='ruby $MYBIN/conversions.rb'
alias duh='du -h'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder;'
alias hk='openssl rand $1 -hex'
alias la='ls -laT'
alias lenv='source $MYBIN/load_env.sh'
alias mkd='function() { echo $1 && mkdir -p $1 && cd "$_" }'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias sr='http-server --cors $1'
alias sshver='nc -v $1 22'
alias tj='echo "# $(date +%Y-%m-%d)\n\n## today\n\n## soon\n\n## done\n\n## journal" >> ~/Documents/journal/$(date +%Y-%m-%d).md && slime ~/Documents/journal'
alias uuid='node -e "function b(a){return a?(a^Math.random()*16>>a/4).toString(16):([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g,b)}; console.log(b())"'
alias notify='function(){ eval "caffeinate $1 && growlnotify -m $2" }'
# alias filecount="find . -type f | awk 'BEGIN {FS=\"/\";} {print $2;}' | sort | uniq -c | sort -rn | less"
# alias errorcount="find . -name '*.txt' | xargs cat | grep 'ERROR' | cut -d ':' -f 2 | sort | uniq -c"
# alias rename="ls | awk '/-shamsi/ {c=$0; gsub(\"-shamsi\", \"-mandala\"); system(\"mv \" c \" \" $0);}'"
# alias follow="tail -fn 1000 <file> | grep <filter>"

#
# node
#

alias node0='echo killing flow and node procs && pkill -f flow & pkill -f node'
alias ys='yarn start'
alias yi='yarn install'
alias yt='yarn test'
alias ytw='yarn test:watch'

#
# open
#

alias chrome='open -a "Google Chrome"'
alias slime='open -a "Sublime Text"'

#
# online pastebin
#

alias ix="curl -F 'f:1=<-' ix.io"

#
# osx
#

alias trash='rm -rf $HOME/.Trash'

#
# redis
#

alias redkeys='$MYBIN/redis_key_size.sh'
alias reddel='function _reddel() { redis-cli KEYS "$1"* | xargs redis-cli DEL };_reddel'

#
# rbenv
#

alias rvc='rbenv version'
alias rvr='rbenv rehash'
alias rvl='rbenv versions'
alias rvu='rbenv local'

#
# secrets
#

alias makecert='f() { openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout $1.key -out $1.crt -subj "/CN=$1" -days 3650};f'
alias makessh='f() { ssh-keygen -t rsa -b 4096 -C "$1" -f $HOME/.ssh/$1 -N "" };f'

#
# sublime
#

alias subsnip='slime ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/'

#
# rsync
#

alias rsync-copy="rsync -av --progress -h"
alias rsync-move="rsync -av --progress -h --remove-source-files"
alias rsync-update="rsync -avu --progress -h"
alias rsync-synchronize="rsync -avu --delete --progress -h"

#
# rust
#

# run type checker
alias cac="cargo check"
# build documentation for all dependencies
alias cad="cargo doc --open"
alias caf="cargo fmt"
# during CI this would be a better check
# "cargo fmt -- --check"
alias car="caf && cargo run"
# output is in targets/debug
alias cab="cargo build"
# output is in targets/release
alias cabr="cargo build --release"

alias rsup="rustup update"
alias rsupnight="rustup install nightly"

#
# youtube-dl
#

alias ytdl='youtube-dl -f "bestvideo[height<=480]+bestaudio/best[height<=480]" $1'
alias ytdlmp3='youtube-dl $1 -x --audio-format "mp3"'

#
# zsh
#

alias zshrc='slime ~/.zshrc'
# reload the $SHELL
alias zsr='exec "$SHELL" -l'


#
# TOOLS
#


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# torch
# . /Users/mattgstevens/torch/install/bin/torch-activate

# nix
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# google cloud SDK
# The next line enables shell command completion for gcloud.
if [ -f '/$HOME/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/$HOME/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# gpg signing git commit messages
export GPG_TTY=$(tty)
