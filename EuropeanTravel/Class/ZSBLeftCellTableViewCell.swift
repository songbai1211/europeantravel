//
//  ZSBLeftCellTableViewCell.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/9.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit


class ZSBLeftCellTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel = UILabel.init(frame: CGRect.init(x: 30, y: 0, width: SCREEN_WIDTH, height: 55))
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.white
        self.contentView.addSubview(titleLabel)
    }
    func setData(titleString : NSString) {
        self.titleLabel.text = titleString as String
    }
    
}
