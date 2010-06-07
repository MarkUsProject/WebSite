#!/bin/bash
#set -xv

# svn up and some housekeeping for mark2

LOGFILE="log/svn_update.log"
export PATH=/bin 		# set path
export RAILS_ENV="test" 	# we want the prod-system reset
export GEM_PATH="/home/markuspr/ruby/gems"

cd /home/markuspr/markus-apps/mark2_trunk
/usr/bin/svn update > $LOGFILE 2>&1

# bring db in sync
sleep 10
/usr/bin/rake db:reset > $LOGFILE 2>&1

touch tmp/restart.txt
