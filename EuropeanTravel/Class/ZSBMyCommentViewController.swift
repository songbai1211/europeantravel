//
//  ZSBMyCommentViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/17.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBMyCommentViewController: UIViewController {
    var tableView:UITableView!
       var datas = [Array<Any>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的评论"
        datas = UserDefaults.standard.object(forKey: "commentData") as? [Array<Any>] ?? []
        
        tableView = UITableView.init(frame:self.view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.register(ZSBCommentsCell.self, forCellReuseIdentifier: "ZSBCommentsCell")
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
       
        
        // Do any additional setup after loading the view.
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
extension ZSBMyCommentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZSBCommentsCell", for: indexPath) as! ZSBCommentsCell
        cell.selectionStyle = .none
        let data = datas[indexPath.row]
        cell.setData(array: data as! Array<String> )
        return cell
    }
}
