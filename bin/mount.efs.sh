#!/bin/sh
#
# sudo mount.efs.sh

if [ -d /dl.x ]
then
	echo "it looks like the EFS filesystem might be mounted already"
	echo "cravenly quitting"
	exit
fi
mv /dl /dl.x

if [ !  -d /dl.efs ]
then
	mkdir /dl.efs
fi

mv /dl.efs /dl

mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-8cb63745.efs.eu-west-1.amazonaws.com:/ /dl
chown prodba:prodba /dl

cd /dl
mkdir arc dump load log stage tmp 2>/dev/null
chown prodba:prodba *

cd /
df -vh
mount
