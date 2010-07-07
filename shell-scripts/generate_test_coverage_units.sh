#!/bin/bash
# set -v

# set environment
PATH="/bin:/usr/bin:/var/lib/gems/1.8/bin" 
#GEM_PATH="/home/markuspr/ruby/gems"
export PATH

# other config
MARKUS_APP_PATH="/home/markus/rcov"
RCOV_LOG_UNITS="$MARKUS_APP_PATH/log/generate_coverage_units.log"

# cleanup from previous runs
rm -rf $MARKUS_APP_PATH/coverage/units

# change dir to markus app
cd $MARKUS_APP_PATH
svn up
rake db:reset "RAILS_ENV=test" >> /dev/null 2>&1
sleep 1
rake db:migrate "RAILS_ENV=test" > /dev/null 2>&1 # run migrations
sleep 1
# generate coverage for unit tests
rcov -o "$MARKUS_APP_PATH/coverage/units" -T -x "/home/markuspr/ruby/.*,rcov.*,lib/.*" --rails  -I"lib:test" "/var/lib/gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader.rb" `ls test/unit/*.rb` #> $RCOV_LOG_UNITS 2>&1
