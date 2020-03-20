//
//  RootTabBarTool.swift
//  LifeNotes
//
//  Created by TLL on 2019/12/9.
//  Copyright © 2019 TLL. All rights reserved.
//

import UIKit

func initConfiguration() {
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.shouldResignOnTouchOutside = true
}
func initData() {
    if UserDefaults.standard.bool(forKey: CreatePlist()) {
        return
    }
    let noteArr:NSArray = NSArray()
    noteArr.write(toFile: PlistFilePath(str: NotePlistKey()), atomically: true)
    
    let billArr:NSArray = NSArray()
    billArr.write(toFile: PlistFilePath(str: BillPlistKey()), atomically: true)
    
    let personArr:NSArray = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "person", ofType: "plist")!)!
    personArr.write(toFile: PlistFilePath(str: PersonPlistKey()), atomically: true)
    
    let categoryArr:NSArray = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "category", ofType: "plist")!)!
    categoryArr.write(toFile: PlistFilePath(str: CategoryPlistKey()), atomically: true)
}
func rootVC() -> UITabBarController{
    
    initData()
    initConfiguration()
    let nav0 = BaseNavigationController.init(rootViewController: Tab0ViewController())
    let nav1 = BaseNavigationController.init(rootViewController: Tab1ViewController())
    let nav2 = BaseNavigationController.init(rootViewController: Tab2ViewController())
    
    let tabBarVC = UITabBarController()
    tabBarVC.viewControllers = [nav0, nav1, nav2]
    let titles = ["Note", "Bill", "Mine"]
    let normalImages = ["tabbar0", "tabbar1", "tabbar2"]
    let selectImages = ["tabbarSelect0", "tabbarSelect1", "tabbarSelect2"]
    for (index, item) in tabBarVC.tabBar.items!.enumerated()
    {
        let nav = tabBarVC.viewControllers![index] as! BaseNavigationController
        nav.topViewController?.title = titles[index]
        
        item.title = titles[index]
        item.image = UIImage(named: normalImages[index])?.withRenderingMode(.alwaysOriginal)
        item.selectedImage = UIImage(named: selectImages[index])?.withRenderingMode(.alwaysOriginal)
    }
    tabBarVC.tabBar.barTintColor = UIColor.init(named: "viewBGColor")
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(named: "textColor0")!
        ], for: UIControl.State.normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red
        ], for: UIControl.State.selected)
    
    UINavigationBar.appearance().tintColor = UIColor.init(named: "textColor0")
    
    return tabBarVC
}

func jumpWeb(rootVC: UIViewController) {
    
//    if !UserDefaults.standard.bool(forKey: PrivateKey()) {
        let vc = NormalWebController()
        vc.showBtnArr = true
        vc.title = "Privacy Policy"
        vc.urlStr = "https://cryptoentertainment.io/private.html"
        let nav = BaseNavigationController.init(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        rootVC.present(nav, animated: true, completion: nil)
//    }
    
//    if !UserDefaults.standard.bool(forKey: IsSearchedKey()) {
//        TLRequestTool.sharedInstance.request(rootVC: rootVC, block: nil)
//    }
}

