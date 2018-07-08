# This script takes from start_ref to stop_ref of a git branch history and
# creates a git repo at dir_name with it.

function usage {
  echo "What?"
  echo "git-transfer.sh performs fast-export and fast-import to create a new repo with the specified history slice."
  echo "Usage:"
  echo "git-transfer 65b343 HEAD your_new_dir"
}

function transfer

if [ $# -ne 3 ]; then
  usage
  exit 1
fi

start_ref=$1
stop_ref=$2
dir_name=$3

git fast-export $start_ref..$stop_ref
cd ..
mkdir $dir_name
cd $dir_name
git init .
git fast-import
