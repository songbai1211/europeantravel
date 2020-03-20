//
//  ZSBSearchViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/10.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBSearchViewController: UIViewController {
    var imagesArry:[NSString]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "国旗列表"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        imagesArry = ["波兰.gif","斯洛伐克.gif","列支敦士登.gif","英国.gif","摩纳哥.gif","瑞士.gif","梵蒂冈 .gif","马耳他骑士团.jpg","拉脱维亚.gif","乌克兰.gif","法国.gif","俄罗斯.gif","德国.gif","保加利亚.gif","圣马力诺.gif","马耳他.gif","意大利.gif","西班牙.gif","葡萄牙.gif","芬兰.gif","丹麦.gif","塞尔维亚.gif","安道尔.gif","阿尔巴尼亚.gif","爱沙尼亚.gif","瑞典.gif","马其顿.gif","黑山.jpg","希腊.gif","奥地利.gif","摩尔多瓦.gif","罗马尼亚.gif","荷兰.gif","波斯尼亚和 黑塞哥维那.gif","斯洛文尼亚.gif","白俄罗斯.gif","挪威.gif","冰岛.gif","克罗地亚.gif","欧盟.jpg","匈牙利.gif","立陶宛.gif","卢森堡.gif","捷克.gif","比利时.gif","爱尔兰.gif"]
        
        setupUI()
    }
    
    func setupUI() {
        let Layout = UICollectionViewFlowLayout.init();
        Layout.itemSize = CGSize.init(width: 120, height: 80)
        Layout.scrollDirection = .vertical
        Layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        let collcetionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: Layout)
        collcetionView.delegate = self
        collcetionView.dataSource = self
        collcetionView.backgroundColor = .clear
        self.view.addSubview(collcetionView)
        collcetionView.register(ZSBSearchCell.self, forCellWithReuseIdentifier: "ZSBSearchCell")
        collcetionView.center = self.view.center
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

extension ZSBSearchViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZSBSearchCell", for: indexPath) as!ZSBSearchCell
        cell.setData(imageName: imagesArry[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZSBSearchCell", for: indexPath) as!ZSBSearchCell
        cell.iconImageView.image = UIImage.init(named: imagesArry[indexPath.row] as String)

        ZSBImageBig.shared.scanBigImageWithImageView(currentImageView: cell.iconImageView!, alpha: 0.5)

    }
}
