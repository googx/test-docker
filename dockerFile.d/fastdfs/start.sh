#!/usr/bin/env bash
#--------------------------------------------------
# File Name: start.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-3-13-下午2:11
#---------------------说明--------------------------
#
#---------------------------------------------------

nohup /usr/bin/fdfs_trackerd /etc/fdfs/tracker.conf start &
nohup /usr/bin/fdfs_storaged /etc/fdfs/storage.conf start &
#nohup /usr/bin/fdfs_trackerd /etc/fdfs/tracker.conf stop &