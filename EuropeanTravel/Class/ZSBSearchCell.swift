//
//  ZSBSearchCell.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/10.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBSearchCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    var iconImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.contentView.backgroundColor = .gray
        iconImageView = UIImageView.init(frame: self.bounds)
        self.contentView.addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFit
        
        
         let bgView = UILabel.init(frame: CGRect.init(x: 0, y: self.contentView.frame.size.height - 20, width: 120, height: 20))
        bgView.font = UIFont.boldSystemFont(ofSize: 13)
        bgView.backgroundColor = .black
        bgView.alpha = 0.5
        bgView.textColor = .white
        self.contentView.addSubview(bgView)
        
        nameLabel = UILabel.init(frame: CGRect.init(x: 0, y: self.contentView.frame.size.height - 20, width: SCREEN_WIDTH, height: 20))
        nameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        nameLabel.textColor = .white
        self.contentView.addSubview(nameLabel)
        nameLabel.text = "德国"
        
        
    }
    func setData(imageName : NSString ) -> Void {
        iconImageView.image = UIImage.init(named: imageName as String)
        let nameCountry = imageName.substring(with: NSRange.init(location: 0, length: imageName.length - 4))
        
        nameLabel.text = nameCountry as String
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
