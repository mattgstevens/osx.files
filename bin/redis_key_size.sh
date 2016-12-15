#!/usr/bin/env bash

# This script prints out all of your Redis keys and their size in a human readable format
# Copyright 2013 Brent O'Connor
# License: http://www.apache.org/licenses/LICENSE-2.0

# 201402 mattgstevens
# pass in params & usage statement

human_size() {
  awk -v sum="$1" ' BEGIN {hum[1024^3]="Gb"; hum[1024^2]="Mb"; hum[1024]="Kb"; for (x=1024^3; x>=1024; x/=1024) { if (sum>=x) { printf "%.2f %s\n",sum/x,hum[x]; break; } } if (sum<1024) print "1kb"; } '
}

function usage {
  echo "What?"
  echo "redis_key_size will print out the size of keys in a redis db"
  echo "Usage:"
  echo "redkeys \"key path\" host port password"
}

if [ "$1" == "-h" ]; then
  usage
  exit 1
fi

keys="${1:-*}"
host="${2:-localhost}"
port="${3:-6379}"
password=$4

if [ $password ]; then
  redis_cmd="redis-cli -p $port -a $password -h $host"
else
  redis_cmd="redis-cli -p $port -h $host"
fi

echo $redis_cmd

# get keys and sizes
for k in `$redis_cmd keys "$keys"`; do key_size_bytes=`$redis_cmd debug object $k | perl -wpe 's/^.+serializedlength:([\d]+).+$/$1/g'`; size_key_list="$size_key_list$key_size_bytes $k\n"; done

# sort the list
sorted_key_list=`echo -e "$size_key_list" | sort -n`

# echo -e $sorted_key_list

# print out the list with human readable sizes
echo -e "$sorted_key_list" | while read l; do
  if [[ -n "$l" ]]; then
    size=`echo $l | perl -wpe 's/^(\d+).+/$1/g'`; hsize=`human_size "$size"`; key=`echo $l | perl -wpe 's/^\d+(.+)/$1/g'`; printf "%-10s%s\n" "$hsize" "$key";
  fi
done
