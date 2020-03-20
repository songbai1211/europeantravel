//
//  ZSBAboutViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/9.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import WebKit
class ZSBAboutViewController: UIViewController {
    var webView:WKWebView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "关于APP"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        
         webView = WKWebView(frame: self.view.bounds)
       self.view.addSubview(webView)
       let url = NSURL.init(string: "https://wandoujiaoyu.com/support.html")
       webView.load(NSURLRequest.init(url: url! as URL) as URLRequest)

        // Do any additional setup after loading the view.
    }
    
    
//    lazy var label:UILabel = {
//        let label = UILabel.init(frame: CGRect.init(x: 40, y: 120, width: SCREEN_WIDTH, height: 120))
//        label.font = UIFont.systemFont(ofSize: 15)
//        label.textColor = UIColor.gray
//        label.numberOfLines = 0
//        label.text =  """
//        要么读书、要么旅行
//
//        身体和灵魂，必须有一个在路上
//
//        前往欧洲，和我们一起去看欧洲杯
//
//        """
//        return label
//    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
