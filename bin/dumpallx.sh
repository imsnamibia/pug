#!/bin/sh
#

. ${HOME}/bin/dlenv

for SCRIPT in ${1}/*dump0*.sh
do
	echo ${SCRIPT}
	./${SCRIPT} > ${DL_LGDIR}/`basename -s .sh ${SCRIPT}`.log 2>&1 &
done

# echo "waiting for background tasks to complete..."
wait							# waits for all child processes to complete

echo "${0} dump complete" > ${DL_LGDIR}/dump.complete
