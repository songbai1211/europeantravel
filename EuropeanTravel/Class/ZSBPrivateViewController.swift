//
//  ZSBPrivateViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/9.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import WebKit
class ZSBPrivateViewController: UIViewController {
    var webView: WKWebView!
    lazy var progressView = UIProgressView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
             self.navigationItem.title = "用户协议"
             self.navigationController?.navigationBar.tintColor = UIColor.white
             self.navigationController?.isNavigationBarHidden = false
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        webView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        let url = NSURL.init(string: "https://wandoujiaoyu.com/agreement.html")
        webView.load(NSURLRequest.init(url: url! as URL) as URLRequest)
        self.progressView.frame = CGRect(x: 0
            , y: webView.frame.origin.y + 44
                    , width: SCREEN_WIDTH
                    , height: 2)
        progressView.progressTintColor = UIColor.red
        progressView.trackTintColor = UIColor.clear
        self.view.addSubview(self.progressView)
   
    }
   

}

extension ZSBPrivateViewController:WKNavigationDelegate{
    
     // 监听网页加载进度
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }
     // 页面开始加载时调用
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        // 当内容开始返回时调用
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
//            Log4jMessage(message: "当内容开始返回...")
        }
        
        // 页面加载完成之后调用
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
            /// 获取网页title
//            self.title = self.wkWebView.title
            MBProgressHUD.hide(for: self.view, animated: true)
            UIView.animate(withDuration: 0.5) {
                self.progressView.isHidden = true
            }
        }
        
        // 页面加载失败时调用
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
            MBProgressHUD.hide(for: self.view, animated: true)

            UIView.animate(withDuration: 0.5) {
                self.progressView.progress = 0.0
                self.progressView.isHidden = true
            }
            /// 弹出提示框点击确定返回
            let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
                _=self.navigationController?.popViewController(animated: true)
            }
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }

}
