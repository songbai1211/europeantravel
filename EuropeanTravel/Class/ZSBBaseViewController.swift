//
//  ZSBBaseViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/12.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = .white
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
