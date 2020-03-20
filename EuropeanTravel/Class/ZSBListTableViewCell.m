//
//  ZSBListTableViewCell.m
//  EuropeanTravel
//
//  Created by crespo on 2020/3/6.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

#import "ZSBListTableViewCell.h"

@interface ZSBListTableViewCell ()
@property(nonatomic,strong)UIImageView *IconImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *adressLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *timelLabel;


@end


@implementation ZSBListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    
    return self;
}


- (void)initView{
    
    self.IconImageView=[UIImageView new];
    [self.contentView addSubview:self.IconImageView];
    [self.IconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 80));
    }];
//    self.IconImageView.layer.masksToBounds=YES;
//    self.IconImageView.layer.cornerRadius=30;
    self.nameLabel =[UILabel new];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.font=[UIFont boldSystemFontOfSize:20];
    self.nameLabel.textColor=ColorWithRGB(0xf2394e);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.IconImageView.mas_right).offset(15);
        make.top.equalTo(self.IconImageView);
        make.height.mas_equalTo(20);

    }];
    
    
    
    self.adressLabel =[UILabel new];
      [self.contentView addSubview:self.adressLabel];
      self.adressLabel.font=[UIFont systemFontOfSize:16];
      self.adressLabel.textColor=[UIColor grayColor];
      [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.nameLabel);
          make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);

      }];
    
    self.detailLabel =[UILabel new];
     [self.contentView addSubview:self.detailLabel];
     self.detailLabel.font=[UIFont systemFontOfSize:13];
    self.detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
     self.detailLabel.textColor=[UIColor lightGrayColor];
     [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.nameLabel);
         make.top.equalTo(self.adressLabel.mas_bottom).offset(10);
       make.height.mas_equalTo(20);
         make.right.equalTo(self.contentView.mas_right).offset(-50);
     }];
    
    
    self.timelLabel =[UILabel new];
        [self.contentView addSubview:self.timelLabel];
        self.timelLabel.font=[UIFont systemFontOfSize:9];
       self.timelLabel.textAlignment = NSTextAlignmentRight;
        self.timelLabel.textColor=[UIColor lightGrayColor];
        [self.timelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-13);
            make.top.equalTo(self.nameLabel.mas_top);
            make.height.mas_equalTo(10);
        }];
        self.timelLabel.text=@"2020/2/12";
            
}

-(void)updateView:(NSArray *)arry{
    self.nameLabel.text=arry[1];
    self.adressLabel.text=arry[2];
    self.detailLabel.text=arry[3];
    
    
  NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)arry[0],
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
   
    [self.IconImageView sd_setImageWithURL:[NSURL URLWithString:encodedString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        CATransition *animation = [CATransition animation];
        animation.duration = .85f;
        animation.type = kCATransitionFade;
        animation.removedOnCompletion = YES;
        [self.IconImageView.layer addAnimation:animation forKey:@"transition"];
        self.IconImageView.image=image;
    }];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
