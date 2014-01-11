# VARS
timestamp=`date +%Y%m%d`
backup_loc=/home/marketing/wordpress_backups/${timestamp}
n_bak=5

database=wordpress
db_user=root
db_dump=${backup_loc}/mysql.dump
db_backup=${backup_loc}/mysql.tar.gz

website=/var/www
web_backup=${backup_loc}/www.tar.gz

# FUNCS

# Create a tar backup
#
# args: from, dest
# from: full path to directory/file to backup
# dest: full path to archive to
function backup {
  from="$1"
  dest="$2"
  start_dir=`pwd`

  if [ -f $dest ]; then
    echo "Creating a backup for existing $dest"
    mv $dest ${dest}_bak
  fi

  cd `dirname $from`
  echo "Archiving $from as $dest"
  tar czf $dest `basename $from`

  echo "Done backup"
  cd $start_dir
}

# Keeps the last 5 days of backups
function cleanup {
  start_dir=`pwd`
  count=$(dirname $backup_loc | xargs ls | wc -l)
  echo "Found $count backups. Settings are to keep $n_bak."

  cd $(dirname $backup_loc)
  for (( ; count > n_bak; count-- )); do
    nfa=$(ls -lt | grep '^d' | tail -1  | tr " " "\n" | tail -1)
    echo "Removing backup dir $nfa"
    rm -rf $nfa
  done

  printf "Done cleanup\n\n"
  cd $start_dir
}

function notify {
  printf "\n##################\n"
}

# MAIN

printf "\nSTART: wordpress backup\n"

# Ensure backup dir exists
mkdir -p $backup_loc

notify
echo "Dumping mysql db $database as $db_dump"
mysqldump $database -u $db_user -p$mysql_pass > $db_dump

notify
echo "Backing up wordpress sql"
backup $db_dump $db_backup
rm $db_dump

notify
echo "Backing up wordpress website"
backup $website $web_backup

notify
echo "Looking to cleanup older backups"
cleanup

printf "END: wordpress backup\n\n"
