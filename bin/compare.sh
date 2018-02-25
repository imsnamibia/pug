#!/bin/sh
#
#

. /protop/bin/protopenv

. ${HOME}/bin/dlenv

pro -p util/compare.p -param ${DL_LGDIR}/wshop.old.tbx,${DL_LGDIR}/wshop.new.tbx
