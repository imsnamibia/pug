#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump06.start

dumptable qad_wkfl 1357                                      #     1.3000 GB  qad_index2

echo "end: " `date` > ${DL_LGDIR}/wshop.dump06.end

#          1 tables,       1.3000 GB
