#!/bin/bash
#set -xv

# short script to generate the MarkUs RDOC available at http://www.markusproject.org/dev/app_doc/

#export PATH=/bin 		# set path
#export RAILS_ENV="production" 	# we want the prod-system reset
#export GEM_PATH="/home/markuspr/ruby/gems" # set gem path, so rcov is available

LOGFILE="log/generate_doc.log"
cd /home/markus/rdoc
svn up > $LOGFILE 2>&1
rake doc:reapp >> $LOGFILE 2>&1
