#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump01.start

dumptable tr_hist 1719                                       #     5.5000 GB  tr_trnbr

echo "end: " `date` > ${DL_LGDIR}/wshop.dump01.end

#          1 tables,       5.5000 GB
