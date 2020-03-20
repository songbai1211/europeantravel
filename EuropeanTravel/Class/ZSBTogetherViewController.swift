//
//  ZSBTogetherViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/16.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import ZLSwipeableView
import MessageUI
class ZSBTogetherViewController: ZSBBaseViewController,ZLSwipeableViewDelegate,ZLSwipeableViewDataSource ,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate{
   
    
    
    
    var datas = Array<Array<Any>>()
    var index = 0
    var xtSwipeableView: ZLSwipeableView?
    var phone: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "一起去玩"
        
      let  iconImageView = UIImageView()
        iconImageView.frame = self.view.bounds
        self.view.addSubview(iconImageView)
        iconImageView.image = UIImage.init(named: "9.jpg")
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
//        showBlurEffectWithUIVibrancyEffect()
        
        datas = getPlist(plistName: "firend") as! [Array<Any>]
        
        showBlurEffect()
        setupUI()
    }
    
    func setupUI(){
            xtSwipeableView = ZLSwipeableView.init()
        xtSwipeableView!.frame = CGRect(x: (screenWidth - 310)/2, y: 180, width: 310, height: 440)
               xtSwipeableView!.delegate = self
               xtSwipeableView!.dataSource = self
               xtSwipeableView!.translatesAutoresizingMaskIntoConstraints = false
               self.view.addSubview(xtSwipeableView!)
    }
    
    override func viewDidLayoutSubviews() {
        xtSwipeableView!.loadViewsIfNeeded()
    }
    func nextView(for swipeableView: ZLSwipeableView!) -> UIView! {
         if self.index >= self.datas.count {
                    self.index = 0
        }
        let view = ZSBCarView.init(frame: swipeableView.bounds)
        view.backgroundColor = RedColor
        view.textLabel?.text = self.datas[self.index][1] as? String
        view.imagesView?.sd_setImage(with: NSURL.init(string: self.datas[self.index][0] as! String) as URL?, completed: nil)
        view.textDetailLabel?.text = self.datas[self.index][2] as? String
        // 闭包回调
        view .initWithClosure(closure: addressThatTakesAClosure)
        self.phone = self.datas[self.index][3] as? String
         index  = index + 1
        return view
    }
    
    
    
    
    func addressThatTakesAClosure(string:String) ->Void{
        // do you something
        
        let alterViewcontroller = UIAlertController.init(title: "请选择联系方式", message: nil, preferredStyle: .actionSheet)
        alterViewcontroller.addAction(UIAlertAction.init(title: "发邮件联系", style: .default, handler: { (alter) in
            
            if MFMailComposeViewController.canSendMail(){
                let controller = MFMailComposeViewController()
                controller.mailComposeDelegate = self
                controller.setSubject("<邀请>")
                self.present(controller, animated: true, completion: nil)
            }else{
                showLoading(info: "本设备不支持邮件发送")
            }
            
            
            
        }))
        alterViewcontroller.addAction(UIAlertAction.init(title: "打电话联系", style: .default, handler: { (alter) in
                   let phone = "telprompt://" + self.phone!
                          if UIApplication.shared.canOpenURL(URL(string: phone)!) {
                              UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: { (bool) in

                              })
                          }else{                showLoading(info: "本设备不支持短信发送")

            }
               }))
        alterViewcontroller.addAction(UIAlertAction.init(title: "发短信联系", style: .default, handler: { (alter) in
                   
            //判断设备是否能发短信(真机还是模拟器)
            if MFMessageComposeViewController.canSendText() {
                let controller = MFMessageComposeViewController()
                //短信的内容,可以不设置
//                controller.body = model.smsContent
                //联系人列表
                controller.recipients = [self.phone] as? [String]
                //设置代理
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            } else {
                showLoading(info: "本设备不支持短信发送")
            }
            
               }))
        alterViewcontroller.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alter) in
            
        }))
        self.present(alterViewcontroller, animated: true, completion: nil)
        
       
        print("\(string)")
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
           self.dismiss(animated: true, completion: nil)
           //判断短信的状态
           switch result{
               
           case .sent:
               print("短信已发送")
           case .cancelled:
               print("短信取消发送")
           case .failed:
               print("短信发送失败")
           default:
               print("短信已发送")
               break
           }
       }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
        switch result{
                  case .sent:
                      print("邮件已发送")
                  case .cancelled:
                      print("邮件取消发送")
                  case .failed:
                    print("邮件发送失败")
                  case .saved:
                        print("邮件保存")
                  default:
                      print("短信已发送")
                      break
                  }
    }
    
    
    
    
    func showBlurEffect() {
    //创建一个模糊效果
    let blurEffect = UIBlurEffect(style: .light)
    //创建一个承载模糊效果的视图
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = self.view.bounds
    let label = UILabel(frame: CGRect(x: 10, y: 80, width: screenWidth - 20, height: 100))
    label.text = "约上朋友一起去旅行✈️"
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.numberOfLines = 0
    label.textAlignment = .center
        label.textColor = RedColor
    blurView.contentView.addSubview(label)
    self.view.addSubview(blurView)
    }
    
    
    
}
