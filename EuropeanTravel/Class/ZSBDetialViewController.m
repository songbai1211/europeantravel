//
//  ZSBDetialViewController.m
//  EuropeanTravel
//
//  Created by crespo on 2020/3/6.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

#import "ZSBDetialViewController.h"
#import "EuropeanTravel-Swift.h"

@interface ZSBDetialViewController ()

@end

@implementation ZSBDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
             self.navigationItem.title=self.array[1];
           self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
         self.navigationController.navigationBarHidden=NO;
    [self initView];
}

- (void)initView{
    
    
    UIImageView *imageView=[UIImageView new];
    [self.view addSubview:imageView];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(120);
        make.size.mas_equalTo(180);
    }];
    NSString *url=self.array.firstObject;
    NSString *encodedString = (NSString *)
      CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                (CFStringRef)url,
                                                                (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                NULL,
                                                                kCFStringEncodingUTF8));
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:encodedString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
           CATransition *animation = [CATransition animation];
           animation.duration = .85f;
           animation.type = kCATransitionFade;
           animation.removedOnCompletion = YES;
           [imageView.layer addAnimation:animation forKey:@"transition"];
           imageView.image=image;
       }];
    
    
    
    UITextView *label=[UITextView new];
    [self.view addSubview:label];
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:20];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.top.equalTo(imageView.mas_bottom).offset(80);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.array[3]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 20; // 调整行间距
    NSRange range = NSMakeRange(0, [self.array[3] length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]} range:range];
    label.attributedText=attributedString;
    
    
    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(60);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    bgView.backgroundColor= [UIColor whiteColor];
    UIView *lineView = [UIView new];
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView);
        make.right.equalTo(bgView.mas_right);
        make.height.mas_equalTo(1);
        make.top.equalTo(bgView);
    }];
    
    lineView.backgroundColor= ColorWithRGB(0xf1f1f1);
    
    
    
    
        UIButton *likeButton = [UIButton buttonWithType:0];
        [bgView addSubview:likeButton];
        likeButton.layer.cornerRadius=8;
        likeButton.layer.masksToBounds=YES;
        likeButton.layer.borderColor=ColorWithRGB(0xf0394e).CGColor;
        likeButton.layer.borderWidth=0.5;
        likeButton.selected = NO;
        [likeButton setTitle:@"收藏" forState:UIControlStateNormal];
        [likeButton setTitleColor:ColorWithRGB(0xf0394e) forState:UIControlStateNormal];
       [likeButton setTitleColor:ColorWithRGB(0xe5e5e5) forState:UIControlStateSelected];

//        likeButton.backgroundColor=ColorWithRGB(0xf0394e);
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_right).offset(-20);
            make.centerY.equalTo(bgView);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        
    [[likeButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        x.selected = !x.selected;
        if (x.selected) {
            x.layer.borderColor=ColorWithRGB(0xe5e5e5).CGColor;
        }else{
            x.layer.borderColor=ColorWithRGB(0xf0394e).CGColor;
        }
        [self like:x.selected];
    }];
    
    
    
    UIButton *commentsButton = [UIButton buttonWithType:0];
    [bgView addSubview:commentsButton];
    commentsButton.layer.cornerRadius=8;
    commentsButton.layer.masksToBounds=YES;
    commentsButton.layer.borderColor=ColorWithRGB(0xf0394e).CGColor;
    [commentsButton setTitle:@"评论" forState:UIControlStateNormal];
    commentsButton.layer.borderWidth=0.5;
    commentsButton.selected = NO;
    [commentsButton setTitleColor:ColorWithRGB(0xf0394e) forState:UIControlStateNormal];
    [commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(likeButton.mas_left).offset(-10);
        make.centerY.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];

    [[commentsButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {

        
        if (![ZSBFIleManger shareInstance].login) {
            ZSBLoginViewController *login = [ZSBLoginViewController new];
            [self.navigationController presentViewController:login animated:true completion:nil];
            return ;
        }
        
        ZSBCommentsViewController *vc=[ZSBCommentsViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

-(void)like:(BOOL)select{
    
    NSMutableArray *nowArray = [NSMutableArray arrayWithArray:self.array];
    [nowArray addObject:[NSDate date].description];
    self.array = [nowArray copy];
    
    NSMutableArray *array=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"likeDatas"]];
    
    [array addObject:self.array];
    NSArray *tempArry=[NSArray arrayWithArray:array];
    [[NSUserDefaults standardUserDefaults]setObject:tempArry forKey:@"likeDatas"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    MBProgressHUD *hub=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hub.bezelView.backgroundColor = ColorWithRGB(0xf2394e);
    hub.label.textColor=[UIColor whiteColor];
    if (select) {
        hub.label.text=@"收藏成功";
    }else{
        hub.label.text=@"取消收藏";
    }
    [hub hideAnimated:YES afterDelay:1];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
