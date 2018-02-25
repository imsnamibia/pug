#!/bin/sh
#

. ${HOME}/bin/dlenv

echo "start: " `date` > ${DL_LGDIR}/wshop.dump08.start

dumptable grac_det 746                                       #     0.7797 GB  grac_ypace
dumptable aud_det 155                                        #     0.4883 GB  aud_entry
dumptable trgl_det 1713                                      #     0.3857 GB  trgl_ref_nbr
dumptable msg_mstr 1167                                      #     0.2336 GB  msg_ln
dumptable usrl_det 1782                                      #     0.1804 GB  usrl_userid
dumptable usrgd_det 1778                                     #     0.1453 GB  oid_usrgd_det

echo "end: " `date` > ${DL_LGDIR}/wshop.dump08.end

#        756 tables,       2.2130 GB
