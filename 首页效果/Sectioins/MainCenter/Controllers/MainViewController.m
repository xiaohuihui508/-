//
//  MainViewController.m
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MainViewController.h"
#import "MainOtherViewController.h"
#import "FUWaveView.h"
#import "UIView+Extension.h"


@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

//数据数组
@property (nonatomic, strong) NSArray *dataList;

//记录清空缓存的index
@property (nonatomic, strong) NSIndexPath *path;

//头view
@property (nonatomic, strong) FUWaveView *waveView;

//是否正在播放动画
@property (nonatomic, assign, getter=isShowWave) BOOL showWave;

@end

@implementation MainViewController

#pragma mark - lazy loading...

- (NSArray *)dataList {
    if (!_dataList) {
        NSMutableDictionary *miaoBi = [NSMutableDictionary dictionary];
        miaoBi[@"title"] = @"我的螃蟹币";
        miaoBi[@"icon"] = @"ic_account_balance_wallet_black_24dp1";
        
        //自己写要跳转到的控制器
        miaoBi[@"controller"] = [MainOtherViewController class];
        
        NSMutableDictionary *zhiBoJian = [NSMutableDictionary dictionary];
        zhiBoJian[@"title"] = @"产品管理";
        zhiBoJian[@"icon"] = @"MoreExpressionShops";
        //自己写要跳转到的控制器
        zhiBoJian[@"controller"] = [MainOtherViewController class];
        
        NSMutableDictionary *shouYi = [NSMutableDictionary dictionary];
        shouYi[@"title"] = @"我的余额";
        shouYi[@"icon"] = @"MoreMyBankCard";
        shouYi[@"controller"] = [MainOtherViewController class];
        
        NSMutableDictionary *liCai = [NSMutableDictionary dictionary];
        liCai[@"title"] = @"邀请积分";
        liCai[@"icon"] = @"buyread";
        liCai[@"controller"] = [MainOtherViewController class];
        
        NSMutableDictionary *cleanCache = [NSMutableDictionary dictionary];
        cleanCache[@"title"] = @"清空缓存";
        cleanCache[@"icon"] = @"img_cache";
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"设置";
        setting[@"icon"] = @"MoreSetting";
        setting[@"controller"] = [MainOtherViewController class];
        
        NSArray *section1 = @[miaoBi, zhiBoJian];
        NSArray *section2 = @[shouYi, liCai];
        NSArray *section3 = @[cleanCache];
        NSArray *section4 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section1, section2, section3,section4, nil];
    }
    return _dataList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
        _tableView.y = -20;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//刷新tableview
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationBar *nav = self.navigationController.navigationBar;
    nav.hidden = YES;
    
}


#pragma mark - life cycle...

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeaderView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupHeaderView {
    
    FUWaveView *wave = [[FUWaveView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 270) Image:@"timg" centerIcon:@"icon"];
    self.waveView = wave;
    [self scrollViewDidScroll:self.tableView];
    
    
    [self.tableView addSubview:wave];
    //    self.tableView.tableHeaderView = wave;
    
    // 与图像高度一样防止数据被遮挡
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W , wave.height)];
    
}



#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    
    if (!indexPath.section && !indexPath.row) {
        cell.detailTextLabel.text = @"270枚";
        cell.detailTextLabel.textColor = XLColor(0.935, 210, 0);
    }
    
    cell.selected = YES;
    
    if ([cell.textLabel.text isEqualToString:@"清空缓存"]){
        
        cell.accessoryView = [[UIView alloc] init];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.dataList[indexPath.section][indexPath.row][@"controller"]){
        UIViewController *vc = [[self.dataList[indexPath.section][indexPath.row][@"controller"] alloc] init];
        
        vc.title = self.dataList[indexPath.section][indexPath.row][@"title"];
        
        vc.view.backgroundColor = XLColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
        
        [self presentViewController:vc animated:YES completion:nil];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !section ? 1 : CGFLOAT_MIN;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.isShowWave) {
        [self.waveView starWave];
    }
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (fabs(offsetY) > 20) {
        self.showWave = YES;
    }
    else {
        self.showWave = NO;
    }
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.waveView stopWave];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        
        self.waveView.frame = CGRectMake(offsetY/2, offsetY, SCREEN_W - offsetY, 270 - offsetY);  // 修改头部的frame值就行了
    }
    
    NSLog(@"%f,%f",self.waveView.height,self.tableView.tableHeaderView.height);
}



@end
