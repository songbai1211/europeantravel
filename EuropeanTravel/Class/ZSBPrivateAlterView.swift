//
//  ZSBPrivateAlterView.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/10.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import WebKit
class ZSBPrivateAlterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var bgButton:UIButton!
    var bgView:UIView!
    var webView:WKWebView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupUI()
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("refreshNetWork"), object: nil, queue: nil) { (noty) in
            self.webView.reload()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        bgButton = UIButton.init(type: .custom)
        bgButton.frame = self.bounds
        bgButton.alpha = 0.5
        bgButton.backgroundColor = .black
        self.addSubview(bgButton)
        
        
        bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.addSubview(bgView)
        bgView.backgroundColor = .white
        bgView.center = self.center
        
        webView = WKWebView(frame: bgView.bounds)
          bgView.addSubview(webView)
          let url = NSURL.init(string: "https://wandoujiaoyu.com/private.html")
          webView.load(NSURLRequest.init(url: url! as URL) as URLRequest)
         
        
        let cancleButton = UIButton.init(frame: CGRect.init(x: 25, y: bgView.frame.size.height - 45, width: bgView.frame.size.width/3, height: 35))
        cancleButton.setTitle("取消", for: .normal)
        cancleButton.setTitleColor(.white, for: .normal)
        cancleButton.layer.masksToBounds = true
        cancleButton.layer.cornerRadius = 3.0
        cancleButton.backgroundColor = UIColor(hexString: "#d0dbdf")
        bgView.addSubview(cancleButton)
        cancleButton.rac_signal(for: .touchUpInside).subscribeNext { (UIControl) in
            self.cancleClick()
        }
        
        let sureButton = UIButton.init(frame: CGRect.init(x: bgView.frame.size.width - 150, y: bgView.frame.size.height - 45, width: bgView.frame.size.width/3, height: 35))
        sureButton.setTitle("确定", for: .normal)
        sureButton.setTitleColor(.white, for: .normal)
        sureButton.layer.masksToBounds = true
        sureButton.layer.cornerRadius = 3.0
        sureButton.backgroundColor = RedColor
        bgView.addSubview(sureButton)
        sureButton.rac_signal(for: .touchUpInside).subscribeNext { (UIControl) in
            self.agreeClick()
        }
    }
    
    
    func agreeClick() {
        UIView.animate(withDuration: 0.3) {
            self.removeFromSuperview()
        }
        UserDefaults.standard.set("1", forKey: "agree")
        UserDefaults.standard.synchronize()
    }
        
    func cancleClick() {
        showLoading(info: "点击同意才能使用APP")
    }
    
}
