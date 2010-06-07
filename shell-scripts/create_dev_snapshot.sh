#!/bin/bash
#
# script to create a development snapshot from source code repository

export PATH="/bin:/usr/bin"
DATE=`date +%Y%m%d`
SNAPSHOT_DIR="/home/markuspr/public_html/dev/snapshots"
LOGFILE="$SNAPSHOT_DIR/create_dev_snapshot.log"

cd $SNAPSHOT_DIR
rm -rf markus_dev*
svn export https://stanley.cdf.toronto.edu/svn/csc49x/olm_rails/trunk markus_dev_$DATE > $LOGFILE 2>&1 
tar -cjf markus_dev_$DATE.tar.bz2 markus_dev_$DATE >> $LOGFILE 2>&1
ln -s markus_dev_$DATE.tar.bz2 markus_dev_latest.tar.bz2
rm -rf markus_dev_$DATE
