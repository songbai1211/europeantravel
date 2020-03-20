//
//  ZSBCommentsViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/16.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import SnapKit
import HandyJSON

class ZSBCommentsViewController: ZSBBaseViewController,commentViewDelegate {
    func sendMessage(message: String) {
        
    }
    
    var tableView:UITableView!
    var datas = [Array<Any>]()
    var commitView = CommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "评论列表"
        
        let array = getPlist(plistName: "comment") as! [Array<Any>]
        
        for _ in 0...Int(arc4random()%40)+1 {
            let yue =  Int(arc4random()%60)+1
            datas.append(array[yue])
        }
        
        
        tableView = UITableView.init(frame:self.view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.register(ZSBCommentsCell.self, forCellReuseIdentifier: "ZSBCommentsCell")
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        setCommentView()
        UIApplication.shared.keyWindow?.endEditing(true)
        // Do any additional setup after loading the view.
    }
    
    func setCommentView(){
        commitView.frame = CGRect.init(x: 0, y: screenHeight-55, width: screenWidth, height: 60)
        commitView.CommentDelegate = self
        self.view.addSubview(commitView)
        NotificationCenter.default.addObserver(forName:UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notify) in
            showKeyBoad(notify: notify)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notify) in
           let kbInfo = notify.userInfo
            let duration = kbInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            UIView.animate(withDuration: duration) {
                self.commitView.frame = CGRect(x: 0, y: screenHeight - 55, width: screenWidth, height: 55)
            }
        }
        
        
        func showKeyBoad(notify:Notification){
            
            let kbInfo = notify.userInfo
            let kbRect = (kbInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let height = kbRect.size.height
            let duration = kbInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            UIView.animate(withDuration: duration) {
                self.commitView.frame = CGRect(x: 0, y: screenHeight - height - 55, width: screenWidth, height: 55)
            }
            
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    
    
}




extension ZSBCommentsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZSBCommentsCell", for: indexPath) as! ZSBCommentsCell
        cell.selectionStyle = .none
        let data = datas[indexPath.row]
        cell.setData(array: data as! Array<String>)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        [self.view endEditing:YES];
        self.view.endEditing(true)
    }
}
