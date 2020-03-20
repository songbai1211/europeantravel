#import "ZSBMainViewController.h"
#import "ZSBListViewController.h"
#import "ZSBAiiCountryViewController.h"
#import "XLSlideMenu.h"
#import "EuropeanTravel-Swift.h"
@interface ZSBMainViewController ()<IGLDropDownMenuDelegate>
@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;
@property(nonatomic,strong)NSArray *dataArry;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ZSBMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.barhide=YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    [self initView];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"plist"];
        //当数据结构为数组时
    [ZSBFIleManger shareInstance].countryArray= [[NSArray alloc] initWithContentsOfFile:plistPath];
    self.imageView.image=[UIImage imageNamed:@"1.jpg"];
    [self changeImaage];
    [self initButton];
    
    if (!ZSBFIleManger.shareInstance.agree) {
    
        ZSBPrivateAlterView *private = [[ZSBPrivateAlterView alloc]initWithFrame:self.view.bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:private];
        private.center = self.view.center;
        
    }
    
    
}

- (void)initButton{
        UIButton *likeButton = [UIButton buttonWithType:0];
         [self.view addSubview:likeButton];
        [likeButton setImage:[UIImage imageNamed:@"gengduo.png"] forState:UIControlStateNormal];
         [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.view.mas_left).offset(30);
             make.top.equalTo(self.view.mas_top).offset(60);
             make.size.mas_equalTo(CGSizeMake(30, 30));
         }];
    @weakify(self);
    [[likeButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.xl_sldeMenu showLeftViewControllerAnimated:true];
    }];
}



- (void)changeImaage{
    NSArray *arry=@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"10.jpg"];

    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
      
        int i = arc4random() % (arry.count-1) ;

        CATransition *animation = [CATransition animation];
        animation.duration = .85f;
        animation.type = kCATransitionFade;
        animation.removedOnCompletion = YES;
        [self.imageView.layer addAnimation:animation forKey:@"transition"];
        
        
        self.imageView.image=[UIImage imageNamed:arry[i]];
    }];
    [timer fire];
    
    
    
}



- (void)initView{
    NSArray *dataArray = @[@{@"image":@"德国.gif",@"title":@"德国"},
                                @{@"image":@"法国.gif",@"title":@"法国"},
                                @{@"image":@"荷兰.gif",@"title":@"荷兰"},
                                @{@"image":@"瑞士.gif",@"title":@"瑞士"},
                              @{@"image":@"捷克.gif",@"title":@"捷克"},
                             @{@"image":@"奥地利.gif",@"title":@"奥地利"},
                             @{@"image":@"比利时.gif",@"title":@"比利时"},
                             @{@"image":@"more",@"title":@"更多国家"},
      
      ];
         NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
         for (int i = 0; i < dataArray.count; i++) {
             NSDictionary *dict = dataArray[i];
             
             IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
             [item setIconImage:[UIImage imageNamed:dict[@"image"]]];
             [item setText:dict[@"title"]];
             [dropdownItems addObject:item];
         }
         
         self.dropDownMenu = [[IGLDropDownMenu alloc] init];
         self.dropDownMenu.menuText = @"欧洲旅行指南";
         self.dropDownMenu.dropDownItems = dropdownItems;
         self.dropDownMenu.paddingLeft = 15;
          self.dropDownMenu.type=IGLDropDownMenuTypeSlidingInBoth;
          self.dropDownMenu.rotate=IGLDropDownMenuRotateRandom;
          self.dropDownMenu.direction=1;
         [self.dropDownMenu setFrame:CGRectMake(ScreenWidth-160,ScreenHeight-80, 140, 45)];
         self.dropDownMenu.delegate = self;
      [self.dropDownMenu reloadView];
      [self.view addSubview:self.dropDownMenu];
      
}


- (void)dropDownMenu:(IGLDropDownMenu *)dropDownMenu selectedItemAtIndex:(NSInteger)index {
   
    if (index ==8) {
    }else if (index==7) {
        ZSBAiiCountryViewController *vc=[ZSBAiiCountryViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZSBListViewController *vc=[ZSBListViewController new];
        vc.dataArry=[ZSBFIleManger shareInstance].countryArray[index];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


@end
