//
//  ZSBMyheadCell.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/17.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBMyheadCell: UITableViewCell {
    var headImageView = UIImageView()
    var nameLabel   = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(headImageView)
        headImageView.layer.cornerRadius = 30
        headImageView.backgroundColor = .white
        headImageView.layer.masksToBounds = true
        headImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(60)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
        nameLabel.text = "用户名"
            
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
