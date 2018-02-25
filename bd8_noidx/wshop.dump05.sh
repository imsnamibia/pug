#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump05.start

dumptable abs_mstr 31                                        #     2.7000 GB  abs_export_batch

echo "end: " `date` > ${DL_LGDIR}/wshop.dump05.end

#          1 tables,       2.7000 GB
