#!/bin/bash
#set -xv

# short script to reset the MarkUs app available at http://www.markusproject.org/admin-demo

export PATH=/bin 		# set path
export RAILS_ENV="production" 	# we want the prod-system reset
export GEM_PATH="/home/markuspr/ruby/gems"

LOGFILE="log/reset_admin_demo_db.log"

cd /home/markuspr/markus-apps/mark1_trunk
/usr/bin/rake repos:drop >> $LOGFILE 2>&1
/usr/bin/rake db:reset RAILS_ENV=production > $LOGFILE 2>&1
/usr/bin/rake markus:usability_test_setup RAILS_ENV=production > $LOGFILE 2>&1
