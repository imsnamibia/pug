#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump02.start

dumptable sod_det 0                                          #     4.1000 GB

echo "end: " `date` > ${DL_LGDIR}/wshop.dump02.end

#          1 tables,       4.1000 GB
