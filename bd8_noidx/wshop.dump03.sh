#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump03.start

dumptable so_mstr 0                                          #     3.6000 GB

echo "end: " `date` > ${DL_LGDIR}/wshop.dump03.end

#          1 tables,       3.6000 GB
