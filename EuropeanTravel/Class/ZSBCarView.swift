//
//  ZSBCarView.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/16.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBCarView: UIView {

    typealias sendValueClosure = (_ string:String)->Void
           /// 声明一个Closure(闭包)
           var myClosure:sendValueClosure?
           /// 下面这个方法需要传入上个界面的someFunctionThatTakesAClosure函数指针
           func initWithClosure(closure:sendValueClosure?){
               myClosure = closure
           }
           ///
           var imagesView: UIImageView?
           var textLabel : UILabel?
            var textDetailLabel : UILabel?

           var btn: UIButton?
           ///
           override init(frame: CGRect) {
               super.init(frame: frame)
            self.setView(frame: frame)
           }
           required init?(coder aDecoder: NSCoder) {
               fatalError("init(coder:) has not been implemented")
           }
           /// setView
           func setView(frame: CGRect){
               // Shadow
            self.layer.shadowColor = RedColor.cgColor
               self.layer.shadowOpacity = 0.33
            self.layer.shadowOffset = CGSize(width: 0, height: 1.5)
               self.layer.shadowRadius = 4.0
               self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
               
               // Corner Radius
               self.layer.cornerRadius = 10.0
               
               // Custom view
            imagesView = UIImageView.init(frame: CGRect(x: 5, y: 5, width: self.frame.size.width - 10, height: self.frame.size.height / 2))
            imagesView!.backgroundColor = UIColor.white
               self.addSubview(imagesView!)
               
               
            textLabel = UILabel.init(frame: CGRect(x: 20, y: imagesView!.frame.size.height + 15, width: 70, height: 20))
            textLabel!.backgroundColor = UIColor.white
            self.addSubview(textLabel!)
            
            textDetailLabel = UILabel.init(frame: CGRect(x: 20, y:textLabel!.frame.origin.y + textLabel!.frame.size.height + 20, width: 265, height: 120))
            textDetailLabel?.layer.cornerRadius = 4
            textDetailLabel?.layer.masksToBounds = true
            textDetailLabel?.numberOfLines = 0
            textDetailLabel?.font = UIFont.systemFont(ofSize: 12)
            textDetailLabel!.backgroundColor = UIColor.white
             self.addSubview(textDetailLabel!)
//            textDetailLabel?.sizeToFit()
            btn = UIButton.init(type: .custom)
            btn?.setTitle("联系我", for: .normal)
            btn?.layer.cornerRadius = 4
            btn?.layer.masksToBounds = true
            btn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn?.layer.borderColor = UIColor.white.cgColor
            btn?.layer.borderWidth = 1
            btn?.frame = CGRect(x: self.frame.size.width - 95, y: self.frame.size.height - 40, width: 70, height: 30)
               self.addSubview(btn!)
            btn?.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
               
           }
           /// 这里实现了btn点击方法的回调, 回到控制器(VC),可实现跳转
          @objc func btnClick()
           {
               if myClosure != nil{
                self.myClosure!("hello World")
               }
           }
}
