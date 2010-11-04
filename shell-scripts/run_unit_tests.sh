#!/bin/bash
#set -xv

# run unit tests for mark2

PATH="/bin:/usr/bin:/var/lib/gems/1.8/bin"	# set path
RAILS_ENV="test" 	# switch to the test env
#GEM_PATH="/home/markuspr/ruby/gems"
#export PATH RAILS_ENV GEM_PATH
export RAILS_ENV PATH
RUBY="/usr/bin/ruby"

LOGFILE="log/unit_tests_report.log"
LOGFILE2="log/unit_tests_report_single.log"
LOGFILE3="log/unit_tests_report_update.log"

cd /home/markus/test_report
rm -fr /home/markus/test_report/log/*.log
git pull -q origin master > $LOGFILE3 2>&1
bundle install
rake db:migrate "RAILS_ENV=production" > /dev/null 2>&1 # avoid pending migrations error

date +Generated\ %h,\ %d\ at\ %T\ %Z > $LOGFILE 2>&1
echo >> $LOGFILE 2>&1
# prepare test database
#rake db:test:purge "RAILS_ENV=test" >> $LOGFILE 2>&1
#rake db:create "RAILS_ENV=test" > /dev/null 2>&1
rake db:reset "RAILS_ENV=test" >> /dev/null 2>&1
sleep 1
rake db:migrate "RAILS_ENV=test" > /dev/null 2>&1 # run migrations
sleep 1
# run tests
rake test:units "RAILS_ENV=test" >> $LOGFILE 2>&1
date +Generated\ %h,\ %d\ at\ %T\ %Z > $LOGFILE2 2>&1
echo >> $LOGFILE2 2>&1
for i in `ls test/unit/*.rb`; do
  $RUBY -I test "$i" >> $LOGFILE2 2>&1
done

# pretty it up a little
mv $LOGFILE $LOGFILE.raw
mv $LOGFILE2 $LOGFILE2.raw
/usr/bin/fold --width=120 $LOGFILE.raw > $LOGFILE 2>&1
/usr/bin/fold --width=120 $LOGFILE2.raw > $LOGFILE2 2>&1
