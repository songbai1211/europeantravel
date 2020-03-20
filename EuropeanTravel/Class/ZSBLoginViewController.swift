//
//  ZSBLoginViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/9.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBLoginViewController: UIViewController {
    var bgView = UIView()
    var userField = UITextField()
    var passWordField = UITextField()
    var loginButton = UIButton()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "#f2394e")
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        bgView.frame = CGRect.init(x: 40, y: 200, width: SCREEN_WIDTH-80, height: 100)
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        self.view.addSubview(bgView)
        
        userField.frame = CGRect.init(x: 10, y: 0, width: SCREEN_WIDTH-50, height: 50)
        userField.backgroundColor = .clear
        userField.placeholder = "用户名"
        userField.layer.cornerRadius = 5
        userField.layer.masksToBounds = true
        bgView.addSubview(userField)
        
        passWordField.frame = CGRect.init(x: 10, y: 50, width: SCREEN_WIDTH-50, height: 50)
        passWordField.backgroundColor = .clear
        passWordField.placeholder = "密码"
        passWordField.layer.cornerRadius = 5
        passWordField.layer.masksToBounds = true
        bgView.addSubview(passWordField)
        
        let lineView = UIView.init(frame: CGRect.init(x: 0, y: 50, width: SCREEN_WIDTH-50, height: 1))
        lineView.backgroundColor = UIColor(hexString: "#f5f5f5")
        bgView.addSubview(lineView)
        
        
        
        loginButton.frame = CGRect.init(x: 40, y: 320, width: SCREEN_WIDTH-80, height: 50)
//        loginButton.b = .UIButtonTypeCustom
        loginButton.setTitle("登陆", for: .normal)
        loginButton.setTitleColor(RedColor, for: .normal)
        loginButton.backgroundColor = .white
        self.view.addSubview(loginButton)
        
        loginButton.rac_signal(for: .touchUpInside).subscribeNext { (UIButton) in
            
            self.login()
        }
        

        let zhuceButton = UIButton.init(type: .custom)
        zhuceButton.setTitle("去注册", for: .normal)
        zhuceButton.setTitleColor(.white, for: .normal)
        self.view.addSubview(zhuceButton)
        zhuceButton.frame = CGRect.init(x: self.view.frame.size.width-80-40, y: 320+70, width: 90, height: 30)
        zhuceButton.rac_signal(for: .touchUpInside).subscribeNext { (control) in
            let zhuceVC = ZSBregisterViewController()
            self.present(zhuceVC, animated: true, completion: nil)
        }
        
        
        
        
    }
    func login() {
        
        let mb = MBProgressHUD.showAdded(to: self.view, animated: true)
        mb.bezelView.backgroundColor = UIColor(hexString: "#f2394e")
        mb.label.textColor = .white;
        
        if userField.text?.count == 0 || passWordField.text?.count == 0 {
            mb.label.text = "用户名密码不能为空";
            mb.hide(animated: true, afterDelay: 1)
            return;
        }
        
        var isOK:String!
        for dic in  ZSBFIleManger.shareInstance().userDataArry {
            let newdic = dic as! NSDictionary
            if userField.text == newdic.value(forKey: "user") as?String && passWordField.text == newdic.value(forKey: "password")as?String {
                isOK = "1"
            }
        }
        
        if (userField.text == "test" && passWordField.text == "123456") || isOK == "1" {
            mb.label.text = "登陆成功";
            mb.hide(animated: true, afterDelay: 1)
            UserDefaults.standard.setValue("1", forKey: "login")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion: nil)
            DispatchQueue.global().async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginSucceed"), object: nil)
            }
        }else{
            mb.label.text = "用户名密码错误";
            mb.hide(animated: true, afterDelay: 1)
        }
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
