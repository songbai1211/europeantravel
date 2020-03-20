//
//  MBLoding.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/16.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class MBLoding: NSObject {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
public  func showLoading(info:String){

    let mb = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    mb.bezelView.backgroundColor = UIColor(hexString: "#f2394e")
    mb.label.textColor = .white;
    mb.label.text = info;
    mb.hide(animated: true, afterDelay: 1)
}
