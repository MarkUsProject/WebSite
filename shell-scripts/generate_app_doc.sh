#!/bin/bash
#set -xv

# short script to reset the MarkUs app available at http://www.markusproject.org/admin-demo

export PATH=/bin 		# set path
export RAILS_ENV="production" 	# we want the prod-system reset
export GEM_PATH="/home/markuspr/ruby/gems" # set gem path, so rcov is available

LOGFILE="log/generate_doc.log"
cd /home/markuspr/markus-apps/mark2_trunk
/usr/bin/rake doc:reapp > $LOGFILE 2>&1
# does not work as of now
#/usr/bin/rake tests:functionals:rcov >> $LOGFILE  2>&1
#/usr/bin/rake tests:units:rcov >> $LOGFILE  2>&1
