#!/bin/bash

# chech paramteres
if [ "$#" -ne 1 ]; then
    echo "Please provide one argument: date in YYYY-MM-DD format, e.g. 2019-07-03"
    exit
fi

# read list.txt file into array 'repos'
IFS=$'\n' read -d '' -r -a repos < ./list.txt

reportName=day-$1

rm -f ./$reportName

echo    "===========================================" >> ./$reportName
echo    "=== Day report for the date: $1 ===" >> ./$reportName
echo -e "===========================================\n" >> ./$reportName

# going through all repositories
for repo in "${repos[@]}"
do
  # retrieve a name of the repository from its full path
  name=$(echo "repos/${repo}" | cut -d'/' -f 3 | cut -d'.' -f 1)

  echo "Processing $name"

  # if there is not repository yet, then clone it (hiding output)
  [ ! -d "repos/$name" ] && (cd repos; git clone $repo >/dev/null 2>&1 )

  # update master breanch of the repository to get latest changes
  (cd repos/$name; git pull origin master >/dev/null 2>&1)

  # apply git log for the given date
  output=$(cd repos/$name; git log  --pretty=format:"%h - %an : %s" --since="$1 00:00" --until="$1 23:59")

  # if there is something in 'output' then write it to the file
  if [[ $output ]]; then
    echo -e "Commits in $name: \n" >> ./$reportName
    echo -e "$output\n" >> ./$reportName
  fi


done

echo "$reportName created!"


