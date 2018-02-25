#!/bin/sh
#

. /protop/bin/protopenv


. ${HOME}/bin/dlenv

proserve ${TGTDIR}/wshop -spin 10000 -B 500000 -B2 100000 -lruskips 100 -lru2skips 100 -tablerangesize 800 -indexrangesize 2000

probiw  ${TGTDIR}/wshop
proapw  ${TGTDIR}/wshop
prowdog ${TGTDIR}/wshop
