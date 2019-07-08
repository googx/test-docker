/*
--------------------------------------------------
 File Name: httpserver.go
 Author: hanxu
 AuthorSite: http://www.thesunboy.com/
 GitSource: https://github.com/thesunboy-com/linuxShell
 Created Time: 2019-7-4-下午5:58
---------------------说明--------------------------

---------------------------------------------------
*/

package WebviewHttpserver

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strconv"
	"strings"
)

var (
	loginfo = log.New(os.Stdout, "[info]:", log.LstdFlags)
	logerr  = log.New(os.Stderr, "[err]:", log.LstdFlags)
)

func Httpserver() {
	listener, err := net.Listen("tcp", "localhost:8888")
	if err != nil {
		logerr.Fatalf("开启tcp:%v监听失败%v \n ", 8888, err)
	}
	
	loginfo.Printf("http server==>%v  \n", "http://localhost:8888")
	
	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		loginfo.Printf("请求==>%v  \n", request.RemoteAddr)
		
		// build body
		bodybuilder := helloHttpBody(request.Header, writer.Header())
		
		// build header
		writer.Header().Add("Content-Type", "text/html")
		bodylen := bodybuilder.Len()
		writer.Header().Add("Content-Length", strconv.Itoa(bodylen))
		// Accept=[text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8]
		
		writer.Write([]byte(bodybuilder.String()))
		
	})
	http.HandleFunc("/t1", func(writer http.ResponseWriter, request *http.Request) {
		body := hello2Body()
		writer.Header().Add("Content-Type", "text/html")
		writer.Header().Add("Content-Length", strconv.Itoa(body.Len()))
		writer.Write([]byte(body.String()))
	})
	
	http.HandleFunc("/t2", func(writer http.ResponseWriter, request *http.Request) {
		body := helloGetCookie()
		writer.Header().Add("Content-Type", "text/html")
		writer.Header().Add("Content-Length", strconv.Itoa(body.Len()))
		writer.Header().Add("Set-Cookie", "token=abc")
		writer.Write([]byte(body.String()))
	})
	
	http.Serve(listener, nil)
}

func helloHttpBody(reqHeader, respHeader http.Header) *strings.Builder {
	writer := new(strings.Builder)
	writer.Write([]byte("<button onclick=\"alert('hello');\">hello</button>"))
	writer.Write([]byte("<div style=\"background:red\">hello</div>\n\n"))
	//
	writer.Write([]byte("\n\n</br></br></br></br></br>\n\n"))
	//
	writer.Write([]byte("\n\n<h1>requestHeader:</h1> </br></br>\n\n"))
	writer.WriteString(headerString(reqHeader))
	//
	writer.Write([]byte("\n\n<h1>responseHeader:</h1> </br></br>\n\n"))
	writer.Write([]byte("\n\n<a href='http://www.baidu.com'>test_A_link</> </br></br>\n\n"))
	writer.WriteString(headerString(respHeader))
	
	return writer
}

func hello2Body() *strings.Builder {
	builder := new(strings.Builder)
	builder.WriteString(`
	
	<!doctype html>
	<html>
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	</head>
	<body>
	<span>sss</span><button onclick="external.invoke('close')">Close</button>
	<button onclick="external.invoke('fullscreen')">Fullscreen</button>
	<button onclick="external.invoke('unfullscreen')">Unfullscreen</button>
	<button onclick="external.invoke('open')">Open</button>
	<button onclick="external.invoke('opendir')">Open directory</button>
	<button text="sss" onclick="external.invoke('save')">Save</button>
	<button onclick="external.invoke('message')">Message</button>
	<button onclick="external.invoke('info')">Info</button>
	<button onclick="external.invoke('warning')">Warning</button>
	<button onclick="external.invoke('error')">Error</button>
	<button onclick="external.invoke('changeTitle:'+document.getElementById('new-title').value)">
		Change title
	</button>
	<input id="new-title" type="text" />
	<button onclick="external.invoke('changeColor:'+document.getElementById('new-color').value)">
		Change color
	</button>
	<input id="new-color" value="#e91e63" type="color" />
	</body>
	</html>
	
	
	`)
	return builder
}

func helloGetCookie() *strings.Builder {
	builder := new(strings.Builder)
	builder.WriteString(`
	<!doctype html>
	<html>
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	</head>
	<body>
	<span>external.invoke(document.cookie)</span><button onclick="external.invoke(document.cookie)">external.invoke(document.cookie)</button>
	<span>alert(document.cookie</span><button onclick="alert(document.cookie)">alert(document.cookie</button>
	<div>
	div
	</div>
	</body>
	</html>
	
	`)
	return builder
}

func headerString(header http.Header) string {
	builder := strings.Builder{}
	for k, v := range header {
		builder.WriteString(k)
		builder.WriteString("=")
		builder.WriteString(fmt.Sprintf("%s", v))
		
		builder.WriteRune('\n')
	}
	return builder.String()
}
