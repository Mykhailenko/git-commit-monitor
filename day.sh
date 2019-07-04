#!/bin/bash

# chech paramteres


if [ "$#" -gt 2 ] || [ "$#" -eq 0 ] ; then
    echo "Example of usage: ./day 2019-07-01 [2019-07-03]"
    exit
fi

from=$1
till=$1
fromtill=$from
reportName=day-$1

if [ "$#" -eq 2 ]; then
   till=$2
   fromtill="$from - $till"
   reportName=day-$1-$2
fi


# read list.txt file into array 'repos'
IFS=$'\n' read -d '' -r -a repos < ./list.txt


rm -f ./$reportName

echo -e "=== Day report for the date: $fromtill ===\n" >> ./$reportName

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
  output=$(cd repos/$name; git log  --pretty=format:"%h - %an : %s" --since="$from 00:00" --until="$till 23:59")

  # if there is something in 'output' then write it to the file
  if [[ $output ]]; then
    echo -e "Commits in $name: " >> ./$reportName
    echo -e "$output\n" >> ./$reportName
  fi


done

echo "$reportName created!"


