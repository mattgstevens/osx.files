# VARS
ruby_ver=1.9.3-p327

function notify {
  printf "\n####################\n$1\n####################\n"
}

# SETUP DEV TOOLS
notify "Setup BEGIN"

notify "Installing rvm"
curl -L https://get.rvm.io | bash -s stable
source $HOME/.rvm/scripts/rvm

notify "Installing ruby $ruby_ver"
rvm install $ruby_ver

notify "Installing brew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
brew update
brew doctor

notify "Installing git"
brew install git

notify "Installing qt"
# needed for capybara webkit driver
brew install qt

notify "Installing redis"
brew install redis
echo "Do you want redis to launch at login? (y/n)"
read res
if [ $res == 'y' ]; then
  ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
fi
# launch redis now
redis-server /usr/local/etc/redis.conf

notify "Installing postgres"
brew install postgres
echo "Do you want postgres to launch at login? (y/n)"
read res
if [ $res == 'y' ]; then
  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
fi
# launch postgres now
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

notify "Setup END"