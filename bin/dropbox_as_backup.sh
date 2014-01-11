# Globals
dropbox="$HOME/Dropbox/_backup"


# Unique actions


function restore_ssh {
  restore "$HOME/.ssh"

  underline "Add ssh keys to keychain and agent? (y/n)"
  read res
  if [ $res == 'y' ]; then
    username=`whoami`
    # TODO: This should loop for all found private keys
    #
    # look at how heroku keys:add works for choosing found keys
    echo "Adding key $username"
    ssh-add -K /Users/mattgstevens/.ssh/$username
  fi

  underline "Add a key to Heroku? (y/n)"
  read res
  if [ $res == 'y' ]; then
    heroku keys:add
  fi
}

function clean_backups {
  underline "Cleaning backup files"

  ls $dropbox/.*_bak
  rm $dropbox/.*_bak

  ls -d $HOME/.*_bak
  rm -rf $HOME/.*_bak

  echo "Done clean"
}


# Helpers


# Compress and encrypt archive
#
# args: from
function backup {
  from=$1

  underline "Backing up $from"

  dir=${from##*/}
  tarfile="$dir.tar.gz"
  gpgfile="$dir.gpg"
  dest=$dropbox/$gpgfile

  origin_pwd=`pwd`
  cd ${from%%/*}

  create_archive $tarfile $dir
  encrypt_archive $gpgfile $tarfile
  store_archive $gpgfile $dest

  underline "Done backup"
  cd $origin_pwd
}

# Decrypt and expand archive
function restore {
  dest=$1

  underline "Restoring to $dest"

  dir=${dest##*/}
  tarfile="$dir.tar.gz"
  gpgfile="$dir.gpg"
  from=$dropbox/$gpgfile

  origin_pwd=`pwd`
  cd ${dest%%/*}

  cp $from ${from##*/}
  decrypt_archive $gpgfile $tarfile
  extract_archive $tarfile $dest

  underline "Done restore"
  cd $origin_pwd
}

# Moves archive to storage
# Ensures backup if collision at dest
#
# args: tarfile, dest
function store_archive {
  tarfile=$1
  dest=$2

  echo "Storing archive as $dest"
  preserve_dest $dest
  mv $tarfile $dest
}

# Creates an archive
#
# args: tarfile, infile
function create_archive {
  tarfile=$1
  infile=$2

  echo "Creating archive $tarfile from $infile"
  tar czf $tarfile $infile
}

# Extracts a tar archive
# Ensures backup if collision at dest
#
# args: tarfile, dest
function extract_archive {
  tarfile=$1
  dest=$2

  preserve_dest $dest
  echo "Extracting archive"
  tar xzf $tarfile
  rm $tarfile
}

# Performs pgp encrypt
#
# args: gpgfile, infile
function encrypt_archive {
  gpgfile=$1
  infile=$2

  echo "Encrypting archive"
  gpg --output $gpgfile -r `whoami` --encrypt $infile
  rm $infile
}

# Performs gpg decrypt
#
# args: gpgfile, outfile
function decrypt_archive {
  gpgfile=$1
  outfile=$2

  echo "Decrypting archive"
  gpg --out $outfile --decrypt $gpgfile
  rm $gpgfile
}

# If dest exists, create a backup copy
#
# args: dest
function preserve_dest {
  dest=$1

  if [ -e $dest ]; then
    echo "Creating a backup for existing $dest"
    mv $dest ${dest}_bak
  fi
}

# Underlines text
#
# args: words
function underline {
  words=$1

  echo $words
  echo "##################\n"
}

function usage {
  echo "What?"
  echo "drop will create and restore archives from $dropbox\n"
  echo "Usage:"
  echo "b/r one of [ssh, work]"
  echo "back to run all backups"
  echo "clean to remove backups"
}


# BEGIN


if [ $# -eq 0 ]; then
  usage
  exit 1
fi

case "$1" in
  'bssh')   backup "$HOME/.ssh";;
  'rssh')   restore_ssh;;
  'bwork')  backup "$HOME/workspace";;
  'rwork')  restore "$HOME/workspace";;
  'back')   backup "$HOME/.ssh"
            backup "$HOME/workspace";;
  'clean')  clean_backups;;
  *) usage
esac
