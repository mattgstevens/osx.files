

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

function cleanup {
  n_bak=5

  start_dir=`pwd`
  count=$(dirname $backup_dir | xargs ls | wc -l)
  echo "Found $count backups. Settings are to keep $n_bak."

  cd $(dirname $backup_dir)
  for (( ; count > n_bak; count-- )); do
    nfa=$(ls -lt | grep '^d' | tail -1  | tr " " "\n" | tail -1)
    echo "Removing backup dir $nfa"
    rm -rf $nfa
  done

  printf "Done cleanup\n\n"
  cd $start_dir
}

function notify {
  printf "\n####################\n$1\n####################\n"
}

function usage {
  echo "What?"
  echo "Will dump and archive a mysql database\n"
  echo "Usage:"
  echo"    (db_name, db_user, db_password, backup_directory)"
}


# MAIN


if [ $# -lt 4 ]; then
  usage
  exit 1
fi

timestamp=`date +%Y%m%d`
printf "\nSTART: db backup ${timestamp}\n"

db_name=$1
db_user=$2
db_pass=$3
backup_dir=$4/${timestamp}
db_dump=${backup_dir}/mysql.dump
db_backup=${backup_dir}/mysql.tar.gz

# Ensure backup dir exists
mkdir -p $backup_dir

notify "Dumping mysql db $db_name as $db_dump"
mysqldump $db_name -u $db_user -p$db_pass > $db_dump

notify "Backing up db"
backup $db_dump $db_backup
rm $db_dump

notify "Looking to cleanup older backups"
cleanup

printf "END: db backup ${timestamp}\n\n"
