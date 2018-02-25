#!/bin/sh
#

. /protop/bin/protopenv

. ${HOME}/bin/dlenv

ps -ef | grep  dlmon.sh | grep -v grep | awk '{print $2}' | xargs kill > /dev/null 2>&1
ps -ef | grep  dump | grep -v grep | grep -v killdump | awk '{print $2}' | xargs kill  > /dev/null 2>&1

