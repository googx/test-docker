#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# --------------------------------------------------
# File Name: app.py
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-2-18-下午12:07
# ---------------------说明--------------------------
#
# ---------------------------------------------------

from datetime import datetime

from flask import Flask
from flask import Response
from flask import request

app = Flask(__name__)

logfilename="file.txt"

@app.route("/")
def helloController():
    log = buildLog(logfilename)
    print(log)

    return Response(response=log)


@app.route("/down")
def downController():
    log = buildLog(logfilename)
    resp = downfile(log)
    return resp


@app.route("/file")
def readfile(filename:str):
    import os
    # files=os.listdir('./appfile')
    # print(files)
    try:
        with open(filename, mode='r+') as textfile:
            text = textfile.read()
            print("读取的文件:", text)
            return text
    except BaseException:
        return "no file."



def buildLog(logfilename:str) -> str:
    """
    生成日志.
    :return:
    """
    nowdate = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    reqip = request.remote_addr;
    lastlog = readfile(logfilename)
    loglist = [lastlog]
    log = "hello,world: {}, you ip:{}\r\n".format(nowdate, reqip)
    loglist.append(log)

    return loglist


def downfile(text: str, filename: str = 'file.txt') -> Response:
    """
    将text文件下载到浏览器,生成response
    :param text:
    :return:
    """
    respheaders = {}
    respheaders['Content-Disposition'] = 'attachment;filename={}'.format(filename)
    resp = Response(response=text, content_type='multipart/form-data', headers=respheaders)
    return resp


if __name__ == '__main__':
    # helloController()
    app.run(host="0.0.0.0", port="5001", debug=True)
