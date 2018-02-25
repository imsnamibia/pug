#!/bin/sh
#
#

. /protop/bin/protopenv

. ${HOME}/bin/dlenv

while true
do

	clear

	echo "Current:" `date`
	echo ""

	cat ${DL_LGDIR}/*.start 2> /dev/null
	echo ""

	cat ${DL_LGDIR}/*.end   2> /dev/null
	echo ""

	# the temp name of a muti-threaded .bd file is table.b#.bd, it gets renamed table.bd# at the end
	#

	echo " dumping:" `ls ${DUMPDIR}/*.bd 2> /dev/null | wc -l`
	ls -lh ${DUMPDIR}/*.bd 2> /dev/null
	echo ""

	echo " loading:" `ls ${LOADDIR}/*.bd 2> /dev/null | wc -l`
	ls -lh ${LOADDIR}/*.bd* 2> /dev/null
	echo ""

	echo "  staged:" `ls ${STGDIR}/*.bd* 2> /dev/null | wc -l`
	echo ""

	echo "archived:" `ls ${ARCDIR}/*.bd* 2> /dev/null | wc -l`
	echo ""

	( grep -i "idxbuild session begin" ${TGTDIR}/${DB}.lg | tail -1 ) 2> /dev/null
	( grep -i "Index rebuild complete" ${TGTDIR}/${DB}.lg | tail -1 ) 2> /dev/null
	echo ""

	ps -ef | grep [_]proutil
	echo ""

	df -vh
	echo ""

	du -h ${DL}
	echo ""

	sleep 10

done
