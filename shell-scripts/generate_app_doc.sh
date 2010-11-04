#!/bin/bash
#set -xv

# short script to generate the MarkUs RDOC available at http://www.markusproject.org/dev/app_doc/

#export RAILS_ENV="production" 	# we want the prod-system reset
#export GEM_PATH="/home/markuspr/ruby/gems" # set gem path, so rcov is available
PATH="/bin:/usr/bin:/var/lib/gems/1.8/bin"
export PATH


LOGFILE="log/generate_doc.log"
cd /home/markus/rdoc
git pull -q origin master > $LOGFILE 2>&1
bundle install
rake doc:reapp >> $LOGFILE 2>&1
