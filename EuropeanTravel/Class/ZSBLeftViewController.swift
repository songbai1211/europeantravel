//
//  ZSBLeftViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/9.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width
fileprivate let cellID = "cellID"
enum LeftListType: Int {
    case about = 0
    case privateInfo
    case MY
    case togetherPlay
    case travleDDialy
    case userData
    case loginOut
}
class ZSBLeftViewController: UIViewController {
    let datas = ["关于APP","用户协议","个人中心","约友一起玩","旅行日记","欧洲旅行数据","退出登录"]
    var mainTableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(hexString: "#f2394e")
        
        let imageBgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.view.addSubview(imageBgView)
        imageBgView.image = UIImage.init(named: "5.jpg")
        //创建一个模糊效果
          let blurEffect = UIBlurEffect(style: .light)
          //创建一个承载模糊效果的视图
          let blurView = UIVisualEffectView(effect: blurEffect)
          blurView.frame = self.view.bounds
        self.view.addSubview(blurView)

        self.setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(notinfity), name: NSNotification.Name(rawValue: "loginSucceed"), object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func notinfity(notinfity : NSNotification){
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.mainTableView.reloadData()
        
    }
    func setupUI() {
        
        mainTableView = UITableView.init(frame: CGRect.init(x: 0, y: 200, width:SCREEN_WIDTH , height: SCREEN_HEIGHT))
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.tableFooterView = UIView()
        mainTableView.register(ZSBLeftCellTableViewCell.self, forCellReuseIdentifier: cellID)
        mainTableView.rowHeight = 55
        mainTableView.separatorColor = .clear
        mainTableView.backgroundColor = UIColor.clear
        mainTableView.tableFooterView = UIView.init()
        self.view.addSubview(mainTableView)
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
//    blurView.contentView.addSubview(label)
    self.view.addSubview(blurView)
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

extension ZSBLeftViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.xl_sldeMenu.showRootViewController(animated: true)
        let nav = self.xl_sldeMenu.rootViewController as!UINavigationController

        switch indexPath.row {
        case LeftListType.about.rawValue:
            let aboutVc = ZSBAboutViewController()
            nav.pushViewController(aboutVc, animated: true)
         case LeftListType.privateInfo.rawValue:
            
            let searchVc = ZSBPrivateViewController()
            nav.pushViewController(searchVc, animated: true)
            
         case LeftListType.MY.rawValue:
            
            if !ZSBFIleManger.shareInstance().login {
                  let login = ZSBLoginViewController()
                  self.present(login, animated: true, completion: nil)
                return
            }
            
            let searchVc = ZSBMyViewController()
            nav.pushViewController(searchVc, animated: true)
         case LeftListType.togetherPlay.rawValue:
            
            let aboutVc = ZSBTogetherViewController()
            nav.pushViewController(aboutVc, animated: true)
            
         case LeftListType.travleDDialy.rawValue:
            
           let searchVc = ZSBTravelListViewController()
            nav.pushViewController(searchVc, animated: true)
            
         case LeftListType.userData.rawValue:
                        
            let searchVc = ZSBTraveLineViewController()
            nav.pushViewController(searchVc, animated: true)
            
         case LeftListType.loginOut.rawValue:
            UserDefaults.standard.setValue("0", forKey: "login")
              UserDefaults.standard.synchronize()
              let login = ZSBLoginViewController()
              nav.present(login, animated: true, completion: nil)
              self.mainTableView.reloadData()
            
        default:
            break
        }
    }
        
    
}
extension ZSBLeftViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ZSBFIleManger.shareInstance().login {
            return datas.count
        }
        return datas.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as!ZSBLeftCellTableViewCell
        cell.setData(titleString: datas[indexPath.row] as NSString)
        cell.selectionStyle = .none;
        return cell
    }
    
    
}

