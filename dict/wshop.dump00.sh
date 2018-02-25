#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "${0} start: " `date` > ${DL_LGDIR}/wshop.dump00.start

# pro  /old/wshop     -p ${HOME}/util/dumpd.p -param "${DUMPDIR}"
# pro  /old/wshop -RO -p ${HOME}/util/dumpd.p -param "${DUMPDIR}"
# mpro /old/wshop     -p ${HOME}/util/dumpd.p -param "${DUMPDIR}"

if [ -f ${SRCDIR}/${DB}.lk ]
then
	mbpro /old/wshop -p ${HOME}/util/dumpd.p -param "${DUMPDIR}"
else
	bpro /old/wshop -p ${HOME}/util/dumpd.p -param "${DUMPDIR}"
fi

echo "${0} end: " `date` > ${DL_LGDIR}/wshop.dump00.end
