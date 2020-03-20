//
//  ZSBTravelListViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/13.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
fileprivate let traveListCellID = "traveListCellID"
class ZSBTravelListViewController: ZSBBaseViewController {
    var tableView:UITableView!
    var datas:[NSArray]!
    var textDatas:[String]!

    var submmitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "旅行文章"
        setupUI()
        
        let path = Bundle.main.path(forResource: "youji", ofType: "plist")!
        
        datas = NSArray(contentsOfFile: path) as? [NSArray]
        

        
        
              
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 240
        view.addSubview(tableView)
        tableView.register(ZSBTravelListCell.self, forCellReuseIdentifier: traveListCellID)
        
        
        submmitButton = UIButton.init(type: .custom)
//        submmitButton.backgroundColor = .white
        submmitButton.setImage(UIImage.init(named: "fabu"), for: .normal)
        view.addSubview(submmitButton)
        submmitButton.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.view)
            make?.bottom.equalTo()(self.view.mas_bottom)?.setOffset(-30)
            make?.size.setSizeOffset(CGSize.init(width: 60, height: 60))
        }
        
        submmitButton.rac_signal(for: UIControl.Event.touchUpInside).subscribeNext { (button) in
            let vc = ZSBFabuViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
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

extension ZSBTravelListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: traveListCellID, for: indexPath)
            as!ZSBTravelListCell
        cell.selectionStyle = .none;
        let arry = datas[indexPath.row]
        let url = arry[0] as! String
        let newUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        cell.iconImageView.sd_setImage(with: NSURL.init(string: newUrl) as URL?, completed: nil)
        
        let title = arry[1] as! String
        cell.infoLabel.text = title
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ZSBDetialViewController()
        let arry = datas[indexPath.row]
        let title = arry[1] as! String
        let url = arry[0] as! String
        let detial = arry[2] as! String

        let newArray = NSMutableArray.init()
        newArray.add(url)
        newArray.add(title)
        newArray.add("")
        newArray.add(detial)
        vc.array = newArray as! [Any]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension String {
    func urlenCode() -> String{
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    func urlDecode() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
