//
//  CommentView.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/16.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

@objc protocol commentViewDelegate {
    func sendMessage(message:String)
}

class CommentView: UIView ,UITextViewDelegate{
    var textView = UITextView()
    var sendButton = UIButton()
    weak var CommentDelegate:commentViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(hexString: "f6f6f6")
        
        self.addSubview(sendButton)
        sendButton.setTitle("发送", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
//        sendButton.layer.borderColor = RedColor.cgColor
        sendButton.backgroundColor = RedColor
        sendButton.layer.cornerRadius = 8
//        sendButton.layer.borderWidth = 1
        sendButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-13)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 60, height: 30))
        }
//        sendButton.rac_signal(for: .touchUpInside).subscribeNext { (control) in
//            self.CommentDelegate?.sendMessage(message: self.textView.text)
//        }
        sendButton.rac_signal(for: .touchUpInside).subscribeNext { (control) in
            showLoading(info: "发布成功，等待审核")
            let  plistArray = NSMutableArray.init(array: UserDefaults.standard.object(forKey: "commentData") as? Array<Any> ?? [])
            var data = [Any]()
            
            data.append("head")
            data.append("我自己")
            data.append(self.textView.text ?? "暂无评论信息")
            plistArray.add(data)
            
            let overArray = plistArray
            UserDefaults.standard.set(overArray, forKey: "commentData")
            UserDefaults.standard.synchronize()
            self.textView.text = nil
            self.textView.resignFirstResponder()
        }
        
        
        self.addSubview(textView)
        textView.backgroundColor = .white
        textView.placeholder = "请输入评论内容"
//        sendButton.layer.borderColor = RedColor.cgColor
       textView.layer.cornerRadius = 8
       textView.layer.masksToBounds = true
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(13)
            make.right.equalTo(sendButton.snp.left).offset(-10)
            make.height.equalTo(40)
            make.centerY.equalTo(self)
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    

}
