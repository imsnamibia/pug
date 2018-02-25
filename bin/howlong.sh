#!/bin/sh
#

TODAY=`date +"%b %d"`

grep "${TODAY}" ${DL_LGDIR}/${1}.dump.log
