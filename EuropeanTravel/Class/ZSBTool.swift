//
//  ZSBTool.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/13.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBTool {
    
}

func goWeb(rootViewController: UIViewController) {
    let vc = MyWebViewViewController()
    let nav = BaseNAVViewController.init(rootViewController: vc)
    nav.modalPresentationStyle = .fullScreen
    rootViewController.present(nav,animated: true,completion: nil)
    
    
}
 
func getPlist(plistName:NSString) -> NSArray {
    guard let path = Bundle.main.path(forResource: plistName as String, ofType: "plist") else { return  NSArray()}
    guard let array = NSArray(contentsOfFile: path) else { return NSArray() }
    
    return array
}
