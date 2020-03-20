//
//  ZSBMyLikeListCell.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/9.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBMyLikeListCell: UITableViewCell {

     var iconImageView   = UIImageView()
    var titileLabel  = UILabel()
    var detialLabel  = UILabel()
    var dateLabel  = UILabel()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI()  {
        iconImageView = UIImageView.init(frame: CGRect.init(x: 15, y: 15, width: 90, height: 90))
        iconImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(iconImageView)
        
        titileLabel = UILabel.init(frame: CGRect.init(x: 120, y: 15, width: SCREEN_WIDTH-170, height: 20))
        titileLabel.font = UIFont.systemFont(ofSize: 15)
        titileLabel.textColor = UIColor(hexString: "#f2394e")
        self.addSubview(titileLabel)
        
        detialLabel = UILabel.init(frame: CGRect.init(x: 120, y: 40, width: SCREEN_WIDTH-170, height: 60))
        detialLabel.font = UIFont.systemFont(ofSize: 13)
        detialLabel.textColor = UIColor.gray
        detialLabel.numberOfLines = 0
        self.addSubview(detialLabel)
        
        
        
        dateLabel = UILabel.init(frame: CGRect.init(x: screenWidth - 170, y: 15, width: 140, height: 20))
       dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.lineBreakMode = .byClipping
       dateLabel.textColor = UIColor.gray
       self.addSubview(dateLabel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(arry:NSArray) {
        
        
        if arry.firstObject is Data{
            iconImageView.image = UIImage.init(data: arry.firstObject as! Data)
        }else{
            let urlString = arry.firstObject as! String
              let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
              let url = NSURL.init(string: newUrl!)
              iconImageView.sd_setImage(with: url as URL?, completed: nil)
        }
        
      
        titileLabel.text = arry[1] as? String
        detialLabel.text = arry[3] as? String
        dateLabel.text = arry.lastObject  as? String
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
