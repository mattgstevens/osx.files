# Restoring a OSX machine
Notes on backing up and performing a fresh install

## Preparation
- prepare USB stick as bootable media
- prepare USB to decrypt backup drive
- backup onetab for chrome
- run `ball` to sync all data


## Perform fresh install
:spinner:


## OSX
- disable spotlight in `~/workspace`
- disable default key bindings for spaces / launchbar
- turn off genie effect for launchbar

## -> install homebrew and cask
https://brew.sh/

cask_args appdir: '/Applications'
tap 'caskroom/cask'
tap 'caskroom/versions'


## update python (used for many installs)
brew 'python3'


## -> dev tools
brew cask install caskroom/versions/sublime-text3
brew cask install docker
brew cask install iterm2
- keepassx
- kubernetic
- oh-my-zsh
- webpack dashboard


## -> terminal
<!-- basics -->
brew install coreutils
<!-- audio -->
brew install ffmpeg
<!-- fun with ascii -->
brew install figlet
<!-- core -->
brew install git
<!-- gpg -->
brew install gnupg
<!-- image compression -->
brew install guetzli
<!-- image manipulation -->
brew install imagemagick
<!-- fun stuff with p2p -->
brew install ipfs
<!-- work with json -->
brew install jq
<!-- more better utils than OSX defaults -->
brew install moreutils
<!-- core -->
brew install openssl
<!-- fast on-the-wire compressions -->
brew install snappy
<!-- pretty print directories -->
brew install tree
<!-- run a command on a timer -->
brew install watch
<!-- sniff those packets -->
brew install wireshark
<!-- work with youtube as a store of videos -->
brew install youtube-dl
<!-- more better compression at rest -->
brew install xz


## -> messaging
brew cask install cryptocat
brew cask install signal
brew cask install skype
brew cask install slack
brew cask install telegram
brew cask install whatsapp


## -> bits and coins
- electrum
- ganache


## -> media
brew cask install skitch
brew cask install sonos
brew cask install vlc
- iExplorer
- pocket
- LICEcap
- calibre


## applications
brew cask install amethyst
brew cask install chrome
brew cask install firefox
brew cask install flux
brew cask install launchbar
- smcFanControl
- Übersicht

### apple store
- pixelmator


## -> storage
brew cask install dropbox
- paperkey


## -> awareness
- brew tap phinze/cask
- brew install brew-cask
- brew cask install awareness


## Languages

### clojurescript
brew install planck

### ethereum
- yarn global add solhydra

### haskell
brew install haskell-stack

### nodejs
- nvm
brew install yarn
yarn global add http-server
yarn global add jsonogram

### purescript
- yarn global add pulp

### python
- virtualenv


## iterm alt movement
action: 'Send Escape Sequence'
- left: [1;5D
- right: [1;5C


## system fonts
- Fira Code
- Interface


## browser extensions
- ghostery
- vanilla cookie manager
- react dev tools
- redux dev tools
- metamask
- onetab
- https everywhere
