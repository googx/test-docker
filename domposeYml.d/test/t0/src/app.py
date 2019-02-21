#!/usr/bin/python3
# coding=utf-8
# --------------------------------------------------
# File Name: 
# Author: hanxu
# AuthorSite: https://www.thesunboy.com/
# Created Time: 2018-07-18 下午2:12
# ---------------------说明--------------------------
#  
# ---------------------------------------------------

from flask import Flask
from redis import Redis

app = Flask(__name__)
# redis = Redis(host='rediss', port=6379)
redis = Redis(host='myredis', port=6379)


# redis = Redis(host='192.168.2.78', port=6379)


@app.route('/')
def hello():
    count = redis.incr('hits')
    value = redis.get("abc")
    return 'this is docker-composessasdf! ' \
           '该页面已被访问 {} 次,{}。\n'.format(count, value)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port="5001", debug=True)
