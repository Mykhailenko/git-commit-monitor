# Git-commit-monitor allows to monitor commits of the several repositories.

## Prerequisite:

 - linux 
 - git
 - ssh access to all repositories you want to access

## How to Install

`git clone htto://github.com/mykhailenko/git-commit-monitor`

`cd git-commit-monitor`

## How it works

By default, list.txt file contains repositories we monitor in ActiveEon.

Edit this file in order to monitor your own repositories.

Then run `day.sh` by providing date in YYYY-MM-DD format, e.g.: `./day.sh 2019-07-03`

Then report `day-2019-07-03` will be created in current folder.

PS: with default repositories it will take slightly more then 2GB.


