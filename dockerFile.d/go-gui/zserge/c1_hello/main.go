/*
--------------------------------------------------
 File Name: main.go
 Author: hanxu
 AuthorSite: http://www.thesunboy.com/
 GitSource: https://github.com/googx/linuxShell
 Created Time: 2019-7-4-下午4:33
---------------------说明--------------------------

---------------------------------------------------
*/

package main

import (
	"flag"
	"github.com/zserge/webview"
	"log"
	"os"
	"t3/p14_webview/zserge/c0_ommon_httpserver"
)

var (
	loginfo = log.New(os.Stdout, "[info]:", log.LstdFlags)
	logerr  = log.New(os.Stderr, "[err]:", log.LstdFlags)
)

func main() {
	url := flag.String("url", "http://localhost:8888/t2", "webview open url.")
	flag.Parse()
	// *url="https://github.com/zserge/webview/issues/236"
	wvsetting := webview.Settings{}
	wvsetting.URL = *url
	wvsetting.Width = 1024
	wvsetting.Height = 1024
	wvsetting.Debug = true
	wvsetting.ExternalInvokeCallback = func(w webview.WebView, data string) {
		loginfo.Printf("ExternalInvokeCallback==>%v  \n", data)
	}
	
	// webview.
	go WebviewHttpserver.Httpserver()
	loginfo.Printf("open url==>%v  \n", *url)
	wv := webview.New(wvsetting)
	wv.Dialog(webview.DialogTypeAlert, webview.DialogFlagInfo, "dialog demo", "hello")
	// wv.Dialog(webview.dialogty)
	// wv.SetFullscreen(true)
	eval := wv.Eval(`
	
	`)
	loginfo.Printf("==>%v  \n", eval)
	
	wv.SetTitle("test webview demo")
	wv.Run()
	
	// webview.Open("test webview demo", *url, 1024, 789, true)
	//
}
