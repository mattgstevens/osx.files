#
# Antigen
#


source ~/antigen.zsh

# plugins

antigen bundle zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
ZSH_AUTOSUGGEST_STRATEGY='match_prev_cmd'

# antigen bundle zsh-users/zsh-syntax-highlighting

# theme config

export TERM="xterm-256color"
# -> execution time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
# -> prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time command_execution_time dir vcs)
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
# -> how many minutes to sample average system load
POWERLEVEL9K_LOAD_WHICH=5
# -> more prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="☯︎ "
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs ram load date)
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
# -> current directory
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=Default
# -> use theme
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k

# use other frameworks
antigen use oh-my-zsh

# apply
antigen apply


#
# EXPORTS
#


HOMEBREW=/usr/local/bin
MYBIN=$HOME/bin
PATH=/usr/bin:/bin:/usr/sbin:/sbin
PSC_PACKAGE=$HOME/workspace/learning/purescript/psc-package
PURS=$HOME/purescript
STACK=$HOME/.local/bin


export PATH="$HOMEBREW:$PATH:$MYBIN:$PURS:$PSC_PACKAGE:$STACK"


#
# ALIASES
#


# active projects
if [ -f $HOME/.projectsrc ]; then
	. $HOME/.projectsrc
fi

# backups
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
alias bwork="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' --exclude='*.ipc' --filter='dir-merge,-n .gitignore' ~/workspace/ '/Volumes/Bali Bull/mattgstevens/workspace/'"
alias bdrop="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Dropbox/ '/Volumes/Bali Bull/mattgstevens/Dropbox/'"
alias bdocs="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Documents/ '/Volumes/Bali Bull/mattgstevens/Documents/'"
alias bssh="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/.ssh '/Volumes/Bali Bull/mattgstevens/.ssh/'"
alias bbackgrounds="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Pictures/Backgrounds '/Volumes/Bali Bull/mattgstevens/Backgrounds/'"
alias bmusic="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Music/ '/Volumes/Bali Bull/mattgstevens/Music/'"
alias bmovies="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Movies/ '/Volumes/Bali Bull/mattgstevens/Movies/'"
alias bdesktop="rsync --archive --verbose --progress --human-readable --delete-excluded --delete-after --exclude='.DS_Store' ~/Desktop/ '/Volumes/Bali Bull/mattgstevens/Desktop/'"
alias bhome="cp ~/.projectsrc ~/.zsh_history '/Volumes/Bali Bull/mattgstevens/HOME/'"
alias bsublime="cp -R ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/* /Volumes/Bali\ Bull/mattgstevens/Application\ Support/Sublime\ Text\ 3/Packages/User/"

# secrets
alias makecert='f() { openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout $1.key -out $1.crt -subj "/CN=$1" -days 3650};f'
alias makessh='f() { ssh-keygen -t rsa -b 4096 -C "$1" -f $HOME/.ssh/$1 -N "" };f'

# clojurescript
alias cljsm='lein clean && lein cljsbuild once min'
alias figboot='rlwrap lein figwheel dev'

# docker
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
# interactive
alias dki='docker run --rm -it -P'
# shell
alias dks='docker run -it $1 /bin/sh'

# special hostname for Docker for mac
# POSTGRES_HOST=docker.for.mac.host.internal

# docker-machine
alias dkm='docker-machine'
alias dkmcreate='docker-machine create --driver virtualbox'
alias dkmcreatedi='docker-machine create --driver digitalocean --digitalocean-access-token'
alias dkmenv='f() { eval "$(docker-machine env $1)" };f'
alias dkmboot='f() { dkm start $1 ; dkmenv $1 };f'

# ethereum
alias mist='/Applications/Mist.app/Contents/MacOS/Mist --rpc http://localhost:8545 --swarmurl "null"'

# find
alias y='ps -ef | grep $1'
alias wat='find . * | xargs grep --mmap -l'
alias wat='find . -name $1 | xargs grep --mmap -l $2'
alias eh='LANG=; grep -ce $1 $2'

# git
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
alias gl='git log'
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

# github
github-user () { curl -i https://api.github.com/users/$1 }

# gpg
alias gpgls='gpg --list-secret-keys --keyid-format LONG'
alias gpgex='gpg --armor --export $1'

# go
alias gota='go test ./...'
alias gopath='GOPATH=`pwd`'

# helper
alias ..='cd ..'
alias afk="date && pmset sleepnow"
alias conversion='ruby $MYBIN/conversions.rb'
alias duh='du -h'
alias hk='openssl rand $1 -hex'
alias ix="curl -F 'f:1=<-' ix.io"
alias la='ls -laT'
alias lenv='source $MYBIN/load_env.sh'
alias mkd='mkdir -p "$1" && cd "$_"'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias sr='http-server --cors $1'
alias tj='echo "# $(date +%Y%m%d)\n\n## today\n\n## soon\n\n## done" >> ~/Documents/journal/$(date +%Y%m%d).md && slime ~/Documents/journal'
alias uuid='node -e "function b(a){return a?(a^Math.random()*16>>a/4).toString(16):([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g,b)}; console.log(b())"'
alias ytdl='youtube-dl -f "bestvideo[height<=480]+bestaudio/best[height<=480]" $1'
alias ytdlmp3='youtube-dl $1 -x --audio-format "mp3"'
# alias filecount="find . -type f | awk 'BEGIN {FS=\"/\";} {print $2;}' | sort | uniq -c | sort -rn | less"
# alias errorcount="find . -name '*.txt' | xargs cat | grep 'ERROR' | cut -d ':' -f 2 | sort | uniq -c"
# alias rename="ls | awk '/-shamsi/ {c=$0; gsub(\"-shamsi\", \"-mandala\"); system(\"mv \" c \" \" $0);}'"
# alias follow="tail -fn 1000 <file> | grep <filter>"

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

# sublime
alias subsnip='slime ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/'

# rsync
alias rsync-copy="rsync -av --progress -h"
alias rsync-move="rsync -av --progress -h --remove-source-files"
alias rsync-update="rsync -avu --progress -h"
alias rsync-synchronize="rsync -avu --delete --progress -h"

# zsh
alias zshrc='slime ~/.zshrc'
alias zsr='source ~/.zshrc'


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
# source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# google cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mattgstevens/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/mattgstevens/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/mattgstevens/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/mattgstevens/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# gpg signing commit messages
export GPG_TTY=$(tty)
