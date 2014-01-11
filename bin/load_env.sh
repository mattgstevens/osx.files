while read LINE
do
  echo $LINE
  export $LINE
done < "./.env"
