#!/bin/sh
#
# change all instances of string1 to string2 in the list of files provided
#
# - a temporary file with a ".changed" extension is created
# - neither string can contain an "@"
# - embedded double-quote characters (") will probably cause problems
#
# usage:
#
#	change oldString newString file1 file2 file3 ... fileN
#

OLD=$1
NEW=$2

if [ -z "${OLD}" ]
then
	echo "No arguments provided."
	echo "usage: $0 oldString newString file1 [file2 file3 ... fileN]"
	exit 2
fi

if [ -z "${NEW}" ]
then
	echo "Not enough arguments provided."
	echo "usage: $0 oldString newString file1 [file2 file3 ... fileN]"
	exit 4
fi

if [ -z "$3" ]
then
	echo "No files to change."
	echo "usage: $0 oldString newString file1 [file2 file3 ... fileN]"
	exit 8
fi

echo "${OLD}" | grep @ > /dev/null
if [ $? -eq 0 ]
then
	echo "oldString contains @ -- change script delimiter."
	exit 16
fi

echo "${NEW}" | grep @ > /dev/null
if [ $? -eq 0 ]
then
	echo "newString contains @ -- change script delimiter."
	exit 16
fi

shift; shift

for FILE
do

	if [ -f ${FILE} ]
	then
		echo ${FILE}
		sed "s@${OLD}@${NEW}@" < ${FILE} > /tmp/${FILE}.changed
		if [ $? -eq 0 ]
		then
			mv /tmp/${FILE}.changed ${FILE}
		fi
	else
		echo "No such file: ${FILE}"
	fi

done

exit 0
