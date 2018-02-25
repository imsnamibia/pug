#!/bin/sh
#

. /protop/bin/protopenv


. ${HOME}/bin/dlenv

proserve ${SRCDIR}/wshop -spin 10000 -B 1500000 -tablerangesize 800 -indexrangesize 2000

probiw  ${SRCDIR}/wshop
proapw  ${SRCDIR}/wshop
prowdog ${SRCDIR}/wshop
