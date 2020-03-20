//
//  ZSBregisterViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/13.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
class ZSBregisterViewController: UIViewController {

    var bgView = UIView()
    var userNameTextFied = UITextField()
    var passwordTextFied = UITextField()
    var passwordAgainTextFied = UITextField()
    var registerButton  = UIButton()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册"
        self.view.backgroundColor = UIColor(hexString: "#f2394e")
        setupUI()
    }
    
    func setupUI() {
        
        
        let   imageView=UIImageView.init(frame: CGRect.init(x: (screenWidth-50)/2, y: 70, width: 50, height: 50))
        self.view.addSubview(imageView)
        imageView.image = UIImage.init(named: "refresh")
        
        
        self.view.addSubview(bgView)
        bgView.backgroundColor = .white
        bgView.frame = CGRect.init(x: 40, y: 120, width:screenWidth-80 , height: 150)
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        
        bgView.addSubview(userNameTextFied)
        userNameTextFied.frame = CGRect.init(x: 10, y: 0, width: screenWidth - 40, height: 50)
        userNameTextFied.backgroundColor = .clear
        userNameTextFied.placeholder = "请输入用户名"
        userNameTextFied.layer.cornerRadius = 5.0
        userNameTextFied.layer.masksToBounds = true
                        
         bgView.addSubview(passwordTextFied) 
         passwordTextFied.frame = CGRect.init(x: 10, y: 50, width: screenWidth - 40, height: 50)
         passwordTextFied.backgroundColor = .clear
         passwordTextFied.placeholder = "请输入密码"
         passwordTextFied.layer.cornerRadius = 5.0
         passwordTextFied.layer.masksToBounds = true
        
        bgView.addSubview(passwordAgainTextFied)
        passwordAgainTextFied.frame = CGRect.init(x: 10, y: 100, width: screenWidth - 40, height: 50)
        passwordAgainTextFied.backgroundColor = .clear
        passwordAgainTextFied.placeholder = "请再次输入密码"
        passwordAgainTextFied.layer.cornerRadius = 5.0
        passwordAgainTextFied.layer.masksToBounds = true

        
        let lineOneView = UIView.init(frame: CGRect.init(x: 0, y: 50, width: screenWidth-50, height: 1))
          lineOneView.backgroundColor = UIColor(hexString: "#f5f5f5")
          bgView.addSubview(lineOneView)
        let lineTwoView = UIView.init(frame: CGRect.init(x: 0, y: 100, width: screenWidth-50, height: 1))
          lineTwoView.backgroundColor = UIColor(hexString: "#f5f5f5")
          bgView.addSubview(lineTwoView)
        
        
        
//        button.buttonType = UIButton.ButtonType.custom
        self.view.addSubview(registerButton)
        registerButton.frame = CGRect.init(x: 40, y: 300, width: screenWidth - 80, height: 50)
        registerButton.setTitle("注册", for: .normal)
        registerButton.backgroundColor = UIColor(hexString: "#f2394e")
        registerButton.setTitleColor(RedColor, for: .normal)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        registerButton.backgroundColor = .white

                
    }
    @objc func register() {
            let mb = MBProgressHUD.showAdded(to: self.view, animated: true)
//               mb.bezelView.backgroundColor = UIColor(hexString: "#f2394e")
//               mb.label.textColor = .white;
               
        if  userNameTextFied.text?.count == 0 || passwordTextFied.text?.count == 0  || passwordAgainTextFied.text?.count == 0{
                   mb.label.text = "用户名密码不能为空";
                   mb.hide(animated: true, afterDelay: 1)
                   return;
               }
        if passwordTextFied.text != passwordAgainTextFied.text {
            mb.label.text = "密码必须一致";
            mb.hide(animated: true, afterDelay: 1)
            return;
        }
                
           mb.label.text = "注册成功";
           mb.hide(animated: true, afterDelay: 1)
        
        let dic = [ "user" :userNameTextFied.text!, "password":passwordTextFied.text! ]
        let array = ZSBFIleManger.shareInstance().userDataArry
        array.add(dic)
        UserDefaults.standard.set(array, forKey: "userInfoDatas")
        
       UserDefaults.standard.setValue("1", forKey: "login")
       UserDefaults.standard.synchronize()
        var controller:UIViewController = self
        while controller.presentingViewController != nil {
            controller = controller.presentingViewController!
        }
        DispatchQueue.global().async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginSucceed"), object: nil)
        }
        controller.dismiss(animated: true, completion: nil)
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

