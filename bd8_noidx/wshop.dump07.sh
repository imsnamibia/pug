#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump07.start

dumptable tx2d_det 1731                                      #     1.1000 GB  tx2d_carrier

echo "end: " `date` > ${DL_LGDIR}/wshop.dump07.end

#          1 tables,       1.1000 GB
