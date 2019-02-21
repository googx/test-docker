#!/usr/bin/python3
# coding=utf-8
# --------------------------------------------------
# File Name: 
# Author: hanxu
# AuthorSite: https://www.thesunboy.com/
# Created Time: 2018-07-25 上午10:23
# ---------------------说明--------------------------
#  
# ---------------------------------------------------

import os;

osname = "名称:" + os.getenv("test");
print("系统" + osname + os.name);
print("环境变量test" + osname + os.getenv("test"));
print("环境变量test2" + osname + os.getenv("test2"));
print("环境变量test3" + osname + os.getenv("test3"));
print("不存在的环境变量：" + os.getenv("test111"));
