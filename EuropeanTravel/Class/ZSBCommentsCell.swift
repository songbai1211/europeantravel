//
//  ZSBCommentsCell.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/16.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import HandyJSON
public class  CommnetModel:HandyJSON {
    
    var imageUrl:String!
    var name:String!
    var info:String!
    required public init() {
        
    }
}


class ZSBCommentsCell: UITableViewCell {

    var headImageView:UIImageView!
    var nameLable:UILabel!
    var commentInfoLable:UILabel!
    var  dateLabel:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(array:Array<String>){
        headImageView.sd_setImage(with: NSURL.init(string: array[0]) as URL?, placeholderImage: UIImage.init(named: "head"), options: [], completed: nil)
        nameLable.text = array[1]
        commentInfoLable.text = array[2]
    }
    
    
    func setupUI(){
        headImageView = UIImageView()
        contentView.addSubview(headImageView)
        headImageView.backgroundColor = UIColor.white
        headImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(13)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        headImageView.layer.cornerRadius = 30
        headImageView.layer.masksToBounds = true
        
        nameLable = UILabel()
        contentView.addSubview(nameLable)
        nameLable.font = UIFont.systemFont(ofSize: 16)
        nameLable.textColor = DeepTextColor
        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(15)
            make.top.equalTo(headImageView)
        }
        nameLable.text = "姓名姓名姓名姓名"
        
        commentInfoLable = UILabel()
        contentView.addSubview(commentInfoLable)
        commentInfoLable.font = UIFont.systemFont(ofSize: 13)
        commentInfoLable.textColor = NomaTextlColor
        commentInfoLable.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(15)
            make.top.equalTo(nameLable.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-15)
        }
        commentInfoLable.text = "详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情"
        
        dateLabel = UILabel()
           contentView.addSubview(dateLabel)
           dateLabel.font = UIFont.systemFont(ofSize: 11)
           dateLabel.textColor = NomaTextlColor
           dateLabel.snp.makeConstraints { (make) in
               make.right.equalTo(contentView).offset(-15)
            make.top.equalTo(headImageView)
           }
        
        let yue =  Int(arc4random()%12)+1
        let ri =  Int(arc4random()%30)+1

        dateLabel.text = String("2019/\(yue)/\(ri)")
        
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
