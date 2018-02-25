#!/bin/sh
#
# sudo umount.efs.sh

if [ -d /dl.efs ]
then
	echo "it looks like the EFS filesystem might be un-mounted already"
	echo "cravenly quitting"
	exit
fi

umount /dl

mv /dl /dl.efs
mv /dl.x /dl

df -vh
mount
