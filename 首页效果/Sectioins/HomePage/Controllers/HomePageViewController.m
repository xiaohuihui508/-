//
//  HomePageViewController.m
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomePageViewController.h"
#import "Cell1.h"
#import "Headview1.h"
#import "GridCell3.h"
#import "Footview0.h"



@interface HomePageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *grid;

@property (nonatomic, strong) NSArray *adverImageArray;//广告图片


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self setUpUI];
    
}
- (void)initUI {
    //轮播图片
    self.adverImageArray = @[@"http://images.static.100kuai.top/advertisement%2Fadvertise13.jpg", @"http://images.static.100kuai.top/advertisement%2Fadvertise18.jpg"];
}

#pragma mark <布局风格>
- (void)setUpUI {
    self.title = @"首页";

    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    //导航栏左侧
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(leftItemButtonClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //导航栏右侧
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"扫一扫" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemButtonClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //主UICollectionView布局
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    _grid = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:_grid];
    
    _grid.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5" alpha:1.0f];
    _grid.delegate = self;
    _grid.dataSource = self;
    
     [_grid registerNib:[UINib nibWithNibName:@"GridCell3" bundle:nil] forCellWithReuseIdentifier:@"GridCell3"];
    [_grid registerNib:[UINib nibWithNibName:@"Cell1" bundle:nil] forCellWithReuseIdentifier:@"Cell1"];
    [_grid registerClass:[Headview1 class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headview1"];
    [_grid registerNib:[UINib nibWithNibName:@"Footview0" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footview0"];
    
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
//每个分区返回item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 2;
}
//返回cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        GridCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCell3" forIndexPath:indexPath];
        gridcell = cell;
    } else {
        Cell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1" forIndexPath:indexPath];
        gridcell = cell;
    }
    
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader){
            
            Headview1 *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headview1" forIndexPath:indexPath];
            [headerView cellReusableViewHeaderImageArray:self.adverImageArray];
            reusableview = headerView;
        }
        if (kind == UICollectionElementKindSectionFooter) {
            Footview0 *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footview0" forIndexPath:indexPath];
            reusableview = footview;
        }
    }
    return reusableview;
}

//item的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        //减1去除误差
        //XunLog(@"########%f", (SCREEN_W-4-4-1)/5;
        return CGSizeMake((SCREEN_W-4-4-1)/4 , SCREEN_W/4 + 20);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(SCREEN_W, cell_height(190)+8);
    }
     return CGSizeMake(0, 0);
}
//head 宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_W, SCREEN_W * 1 / 4); //图片滚动的宽高

    }
    return CGSizeMake(0, 0);
}
//foot 宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_W, 50);  //淘宝头条的宽高
    }
    return CGSizeZero;
}
//边缘间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 2.0f);
    }
    return UIEdgeInsetsZero;
}
//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

#pragma mark <导航栏的相应事件>
- (void)leftItemButtonClick {
    FULog(@"您点击了消息");
}
- (void)rightItemButtonClick {
    FULog(@"您点击了扫一扫");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
