//
//  ZSBmyLikeViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/9.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBmyLikeViewController: UIViewController {

    var datas:NSArray!
    var isWenzhang:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        if isWenzhang{
            self.navigationItem.title = "我的文章"
        }else{
            self.navigationItem.title = "我的收藏"
        }
             self.navigationController?.navigationBar.tintColor = UIColor.white
             self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor(hexString: "#f2394e")

        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        let tableView = UITableView.init(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView.init()
//        tableView.separatorStyle = .none
        tableView.register(ZSBMyLikeListCell.self, forCellReuseIdentifier: "ZSBMyLikeListCell")
        self.view.addSubview(tableView)
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


extension ZSBmyLikeViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZSBMyLikeListCell", for: indexPath) as!ZSBMyLikeListCell
        cell.setData(arry: datas[indexPath.row] as! NSArray)
        cell.selectionStyle = .none;
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isWenzhang {
            showLoading(info: "通过审核之后才能查看")
            return
        }
        let detailVC = ZSBDetialViewController.init()
        let arry = datas[indexPath.row] as! NSArray
        detailVC.array = (arry as! [Any] as! NSMutableArray) as! [Any]
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}
