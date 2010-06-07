#!/bin/bash
# set -v

# set environment
PATH="/bin:/home/markuspr/ruby/custom-ruby/bin" #ruby and rcov are found there
GEM_PATH="/home/markuspr/ruby/gems"
export PATH GEM_PATH

# other config
MARKUS_APP_PATH="/home/markuspr/markus-apps/mark2_trunk"
RCOV_LOG_UNITS="$MARKUS_APP_PATH/log/generate_coverage_units.log"

# cleanup from previous runs
rm -rf $MARKUS_APP_PATH/coverage/units

# change dir to markus app
cd $MARKUS_APP_PATH
# generate coverage for unit tests
rcov -o "$MARKUS_APP_PATH/coverage/units" -T -x "/home/markuspr/ruby/.*,rcov.*,lib/.*" --rails  -I"lib:test" "/home/markuspr/ruby/gems/gems/rake-0.8.7/lib/rake/rake_test_loader.rb" `ls test/unit/*.rb` > $RCOV_LOG_UNITS 2>&1
