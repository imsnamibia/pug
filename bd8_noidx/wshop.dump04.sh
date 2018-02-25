#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump04.start

dumptable gltr_hist 727                                      #     3.0000 GB  gltr_eff_dt

echo "end: " `date` > ${DL_LGDIR}/wshop.dump04.end

#          1 tables,       3.0000 GB
