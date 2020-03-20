//
//  ZSBchangeNameViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/17.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBchangeNameViewController: ZSBBaseViewController {
        var nameTextField = UITextField()
       var changeButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改昵称"
                self.view.backgroundColor = UIColor(hexString: "#f5f5f5")
                nameTextField.frame = CGRect.init(x: 0, y: 100, width: screenWidth, height: 50)
                nameTextField.backgroundColor = .white
                nameTextField.placeholder = "请输入昵称"
                self.view.addSubview(nameTextField)
                self.navigationController?.navigationBar.tintColor = .white;

                changeButton.frame = CGRect.init(x: 40, y: 200, width: screenWidth-80, height: 50)
                changeButton.setTitle("确认修改", for: .normal)
                changeButton.setTitleColor(UIColor.white, for: .normal)
                changeButton.backgroundColor = RedColor
                self.view.addSubview(changeButton)
                           
                changeButton.addTarget(self, action: #selector(changeName), for: .touchUpInside)
                changeButton.layer.cornerRadius = 8
                changeButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    @objc func changeName() {
           if nameTextField.text?.count == 0  {
            showLoading(info: "昵称不能为空")
               return;
           }
            NotificationCenter.default.post(name: Notification.Name.init("changeName"), object: nil)
           showLoading(info: "修改成功")
           UserDefaults.standard.setValue(nameTextField.text, forKey: "nickname")
           UserDefaults.standard.synchronize()
           self.navigationController?.popViewController(animated: true);
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
