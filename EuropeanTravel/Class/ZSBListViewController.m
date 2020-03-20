//
//  ZSBListViewController.m
//  EuropeanTravel
//
//  Created by crespo on 2020/3/6.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

#import "ZSBListViewController.h"
#import "ZSBListTableViewCell.h"
#import "ZSBDetialViewController.h"
@interface ZSBListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTableView;


@end

@implementation ZSBListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
        self.navigationItem.title=@"旅行列表";
      self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden=NO;
    // Do any additional setup after loading the view.
    [self initView];
  
}
-(void)initView{
    self.mainTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.delegate=self;
    self.mainTableView.dataSource=self;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.rowHeight=150;
    self.mainTableView.backgroundColor=[UIColor whiteColor];
    self.mainTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerClass:[ZSBListTableViewCell class] forCellReuseIdentifier:@"ZSBListTableViewCell"];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.mainTableView.tableFooterView=[UIView new];

}

- (void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mainTableView.mj_header endRefreshing];
        self.mainTableView.mj_footer.state=MJRefreshStateNoMoreData;

    });
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZSBDetialViewController *vc=[ZSBDetialViewController new];
    vc.array=self.dataArry[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZSBListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZSBListTableViewCell"];
    [cell updateView:self.dataArry[indexPath.row]];
    cell.selectionStyle=0;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArry.count;
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
