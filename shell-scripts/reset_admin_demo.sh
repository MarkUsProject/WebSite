#!/bin/bash
#set -xv

# short script to reset the MarkUs app available at http://www.markusproject.org/admin-demo

# set environment
#PATH="/bin:/usr/bin:/var/lib/gems/1.8/bin"
#GEM_PATH="/home/markuspr/ruby/gems"
#export PATH
export RAILS_ENV="production" 	# we want the prod-system reset

LOGFILE="log/reset_admin_demo_db.log"

cd /home/markus/demo/markus
git pull origin master >> $LOGFILE 2>&1
bundle install > $LOGFILE 2>&1
bundle exec rake repos:drop > $LOGFILE 2>&1
bundle exec rake db:reset RAILS_ENV=production > $LOGFILE 2>&1
bundle exec rake db:populate RAILS_ENV=production > $LOGFILE 2>&1
bundle exec rake load:results short_id=A3 RAILS_ENV=production > $LOGFILE 2>&1
