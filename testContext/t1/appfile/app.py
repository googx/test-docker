#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#--------------------------------------------------
# File Name: app.py
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-2-18-下午12:07
#---------------------说明--------------------------
#
#---------------------------------------------------

from flask import Flask
from datetime import datetime
app=Flask(__name__)



@app.route("/")
def helloController():
    nowdate=datetime.now()
    nowdate=datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    reqlog="hello,world: {}".format(nowdate)
    print(reqlog)
    return reqlog

@app.route("/file")
def readfile():
    with open("text1",mode='rw') as textfile:
        text=textfile.read()
        print("读取的文件:",text)
        return  text

if __name__ == '__main__':
    # helloController()
    app.run(host="0.0.0.0", port="5001", debug=True)