//
//  BaseNAVViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/13.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class BaseNAVViewController: UINavigationController ,UINavigationControllerDelegate,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override var childForStatusBarStyle: UIViewController?{
        get{
            return self.topViewController
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
