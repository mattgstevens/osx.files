# Restoring a OSX machine
Notes on backing up and performing a fresh install


## Preparation
- prepare USB stick as bootable media
- prepare USB to decrypt backup drive
- backup onetab for chrome
- run `ball` to sync all data


## Perform fresh install
:spinner:

## copy over needed files from backup drive


## update DNS server to use 1.1.1.1 project
https://1.1.1.1


## -> install homebrew
https://brew.sh/


## -> dev tools
- brew cask install sublime-text
- brew cask install docker
- brew cask install iterm2
  * set color theme
    - Preference -> Profiles -> Colors -> Color presets (solarized dark)
  * allow alt & arrow key movement
    - Preference -> Keys
    - action: 'Send Escape Sequence'
      - left: b
      - right: f
  * set Prefereces -> Profile -> General -> Working directory reuses previous session
- https://ohmyz.sh
- https://www.keepassx.org
  * set preferences to auto lock
- gotop
  * https://github.com/cjbassi/gotop
- fzf -> faster terminal searching
  * brew install fzf
- dive -> tool for looking at Docker layers
- brew tap wagoodman/dive
- brew install dive

## -> terminal
<!-- basics -->
- brew install coreutils
<!-- audio -->
- brew install ffmpeg
<!-- fun with ascii -->
- brew install figlet
<!-- git -->
- brew install git
- brew install git-extras
<!-- gpg -->
- brew install gnupg
<!-- image compression -->
- brew install guetzli
<!-- image manipulation -->
- brew install imagemagick
<!-- fun stuff with p2p -->
- brew install ipfs
<!-- work with json -->
- brew install jq
<!-- more better utils than OSX defaults -->
- brew install moreutils
<!-- baseline ssl for many other installs -->
- brew install openssl
<!-- recursively searches for a regex, using gitignore rules -->
- brew install ripgrep
<!-- fast on-the-wire compressions -->
- brew install snappy
<!-- pretty print directories -->
- brew install tree
<!-- run a command on a timer -->
- brew install watch
<!-- sniff those packets -->
- brew install wireshark
<!-- work with youtube as a store of videos -->
- brew install youtube-dl
<!-- more better compression at rest -->
- brew install xz


## better defaults for OSX
- git clone
- `~/.osx-setup.sh`


## -> web dev
- webpack dashboard
  * https://github.com/FormidableLabs/webpack-dashboard


## -> kubernetes
- kubernetic
  * https://www.kubernetic.com/
- kubetail
  * brew tap johanhaleby/kubetail && brew install kubetail
- kubectx
  * brew install kubectx


## -> messaging
- brew cask install signal
- brew cask install skype
- brew cask install slack
- brew cask install telegram
- brew cask install whatsapp
- cryptocat


## -> bits and coins
- electrum


## -> media
- brew cask install skitch
- brew cask install vlc
- calibre
- iExplorer
- LICEcap
- pocket
- sonos
- servo


## applications
- brew cask install amethyst
  * allow Accessibility in `Security & Privacy`
  * turn on "start at login"
  * update key bindings
- brew cask install awareness
- brew cask install firefox
- brew cask install flux
  * configure to "classic flux"
- brew cask install google-chrome


## -> storage
- brew cask install dropbox
- paperkey


## Languages

### clojurescript
- brew install planck

### ethereum
- yarn global add solhydra
- yarn global add truffle-flattener
- pip3 install manticore
- pip3 install slither
- download and install echidna
- curl https://dapp.tools/install | sh

### haskell
- brew install haskell-stack

### nodejs
- nvm
  * https://github.com/creationix/nvm
- brew install yarn
- yarn global add http-server
- yarn global add jsonogram
- yarn global add graphqurl
- yarn global add node-notifier


### python
- virtualenv


## OSX
- turn on filesystem encryption
- disable user interface sounds
- show battery percentage
- disable spotlight for directory `~/workspace`
- disable default key bindings for spaces / launchbar
- activity monitor -> Dock Icon is display App icon
- keyboard modifier keys -> caps lock to control
- change computer name
- Safari -> View "show status bar" (to get link hover URL preview)


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
