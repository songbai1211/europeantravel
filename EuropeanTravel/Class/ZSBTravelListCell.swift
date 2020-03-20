//
//  ZSBTravelListCell.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/13.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBTravelListCell: UITableViewCell {

    var iconImageView = UIImageView()
    var infoLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
      
    }
    
    
    
    func setupUI() {
        contentView.addSubview(iconImageView)
        iconImageView.backgroundColor = UIColor.white
        iconImageView.mas_makeConstraints { (make) in

            make?.edges.equalTo()(self)
        }
        iconImageView.image = UIImage.init(named: "9.jpg")
        contentView.addSubview(infoLabel)
        infoLabel.textColor = .white
        
        let bgView = UIView.init()
        contentView.addSubview(bgView)
        bgView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self)
        }
        bgView.backgroundColor = .black
        bgView.alpha = 0.3
        
        
        
        infoLabel.textColor = .white
        contentView.addSubview(infoLabel)
        infoLabel.numberOfLines = 2
        infoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let  matrix = CGAffineTransform.init(a: 1, b: 0, c: CGFloat(tanf(Float(-15 * Double.pi/180.0))), d: 1, tx: 0, ty: 0)
        infoLabel.transform = matrix
        
        infoLabel.mas_makeConstraints { (make) in
//            make?.left.equalTo()(self)?.setOffset(50)
//            make?.right.equalTo()(self.mas_right)?.setOffset(50)
            make?.height.setOffset(45)
            make?.width.setOffset(320)
            make?.center.equalTo()(self)
        }
        infoLabel.text = "欧洲一日游，最美的旅行就在欧洲"
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
