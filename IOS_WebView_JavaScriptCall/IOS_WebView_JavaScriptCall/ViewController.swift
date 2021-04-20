//
//  ViewController.swift
//  IOS_WebView_JavaScriptCall
//
//  Created by ssemm on 2021/04/15.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("call 진입")
        print(message)
        
        if(message.name == "success"){
            print("success 호출 \(message.body)")
        }
    }
    

//    @IBOutlet weak var myWebView: WKWebView!
    var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 초기화면
        loadWebpage(url: "https://www.osdew.com/app/api/Sample_JS_DuplexCommunication.html")
    }

    // 네이티브앱 버튼 클릭 시 자바스크립트 함수 호출
    @IBAction func btnCall(_ sender: UIButton) {
        self.myWebView?.evaluateJavaScript("changeColor()", completionHandler: {result, error in
            if error != nil{
                print("에러")
            }
            print("함수 호출")
        })
    }
    
    // 웹페이지 띄우는 함수
    func loadWebpage(url:String){
        let myUrl = URL(string: url)    // URL타입으로 바꿔줘야함
        let myRequest = URLRequest(url: myUrl!)
        
        
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        contentController.add(self, name: "success")
        config.userContentController = contentController
        
        myWebView = WKWebView(frame: self.view.frame, configuration: config)
        myWebView.uiDelegate = self
        myWebView.navigationDelegate = self
        
        self.view.addSubview(myWebView)
        
        myWebView.load(myRequest)
    }
}

