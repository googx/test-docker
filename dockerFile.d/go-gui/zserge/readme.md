## 使用webview+native来搭建本地客户端 demo

#### 框架: 
 使用框架[zserge/webview](github.com/zserge/webview)来搭建  

#### 依赖环境

#### 安装:
   ```
    $ go get -t github.com/zserge/webview
   ```

#### 问题:
   1. 安装框架失败.没有libwebkit2gtk框架. 
    [解决方案](https://github.com/zserge/webview/issues/230) `sudo apt-get install libwebkit2gtk-4.0-dev`

#### 参考

[1.使用go语言和webview编写桌面应用](https://www.jianshu.com/p/176c21427206)