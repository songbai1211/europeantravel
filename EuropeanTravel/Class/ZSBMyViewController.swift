//
//  ZSBMyViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/17.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBMyViewController: ZSBBaseViewController {
    var tableView = UITableView()
    var selectPhotoManager:SelectPhotoManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的界面"
        navigationController?.navigationBar.tintColor = .white
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(ZSBMyheadCell.self, forCellReuseIdentifier: "ZSBMyheadCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.separatorColor = UIColor(hexString: "#f5f5f5")
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let button = UIButton.init()
        button.setTitle("修改昵称", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.rac_signal(for: .touchUpInside).subscribeNext { (button) in
            let vc = ZSBchangeNameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let barRightItem = UIBarButtonItem.init(customView: button)
        navigationItem.rightBarButtonItem = barRightItem
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("changeName"), object: nil, queue: nil) { (noty) in
                   self.tableView.reloadData()
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

extension ZSBMyViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 250));
        imageView.image = UIImage.init(named: "bg.png")
        return imageView
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
            return 60
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZSBMyheadCell", for: indexPath) as! ZSBMyheadCell
            cell.selectionStyle = .none
            
            let data = UserDefaults.standard.object(forKey: "myHeadImage")
            if (data != nil) {
                cell.headImageView.image = UIImage.init(data: data as! Data)
            }else{
                cell.headImageView.image = UIImage.init(named: "head")
            }
            
            let name = UserDefaults.standard.object(forKey: "nickname") as? String
            if name != nil {
                cell.nameLabel.text = name
            }else{
                cell.nameLabel.text = "昵称"
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            
            cell.textLabel?.textColor = NomaTextlColor
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            if indexPath.row == 1 {
                cell.textLabel?.text = "我的收藏"
                cell.imageView?.image = UIImage.init(named: "like")
            }else if indexPath.row == 2 {
                cell.textLabel?.text = "我的评论"
                cell.imageView?.image = UIImage.init(named: "commnet")
            } else if indexPath.row == 3 {
                cell.textLabel?.text = "我发表的文章"
                cell.imageView?.image = UIImage.init(named: "wenzhang")
            }
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            
            self.selectPhotoManager = SelectPhotoManager.init()
            self.selectPhotoManager.startSelectPhoto(withImageName: "修改头像")
            self.selectPhotoManager.successHandle = { (manager,image) ->() in
                UserDefaults.standard.setValue(image?.jpegData(compressionQuality: 0.5), forKey: "myHeadImage")
                UserDefaults.standard.synchronize()
                self.tableView.reloadData()
            }
            
            let vc = ZSBmyLikeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
         case 1:
            let vc = ZSBmyLikeViewController()
          let  datas = UserDefaults.standard.object(forKey: "likeDatas") as? NSArray ?? NSArray.init()
            vc.datas = datas
            vc.isWenzhang = false
           self.navigationController?.pushViewController(vc, animated: true)
            case 2:
            let vc = ZSBMyCommentViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            case 3:
            let vc = ZSBmyLikeViewController()
            let  datas = UserDefaults.standard.object(forKey: "wenzhangData") as? NSArray ?? NSArray.init()
            vc.datas = datas
            vc.isWenzhang = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            return
        }
    }
    
}
