#!/bin/bash
# set -v

# set environment
PATH="/bin:/usr/bin:/var/lib/gems/1.8/bin" 
#GEM_PATH="/home/markuspr/ruby/gems"
export PATH

# other config
MARKUS_APP_PATH="/home/markus/rcov"
RCOV_LOG="$MARKUS_APP_PATH/log/generate_coverage.log"

# cleanup from previous runs
rm -rf $MARKUS_APP_PATH/coverage/*
rm -rf $MARKUS_APP_PATH/log/*

# change dir to markus app
cd $MARKUS_APP_PATH
git pull -q origin master > $RCOV_LOG 2>&1
rake db:reset "RAILS_ENV=test" >> /dev/null 2>&1
sleep 1
rake db:migrate "RAILS_ENV=test" > /dev/null 2>&1 # run migrations
sleep 1
# generate coverage for unit and functional tests
rcov --no-html -T -x "/home/markuspr/ruby/.*,rcov.*,lib/.*" --rails  -I"lib:test" "/var/lib/gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader.rb" `ls test/unit/*.rb` --aggregate $MARKUS_APP_PATH/coverage.data  > $RCOV_LOG 2>&1
rcov -o "$MARKUS_APP_PATH/coverage" -T -x "/home/markuspr/ruby/.*,rcov.*,lib/.*" --rails  -I"lib:test" "/var/lib/gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader.rb" `ls test/functional/*.rb` --aggregate $MARKUS_APP_PATH/coverage.data > $RCOV_LOG 2>&1
