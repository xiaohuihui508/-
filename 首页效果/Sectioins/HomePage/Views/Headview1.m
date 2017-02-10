//
//  Headview1.m
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Headview1.h"

@implementation Headview1

- (void)cellReusableViewHeaderImageArray:(NSArray *)imageArr {
    _cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W * 1 / 4) imageURLStringsGroup:imageArr];
    if (imageArr.count == 1) {
        _cycleScrollview.showPageControl = NO;
        _cycleScrollview.autoScrollTimeInterval = 1000000000;
    } else {
        _cycleScrollview.autoScrollTimeInterval = 5.0;
        _cycleScrollview.showPageControl = YES;//显示分页控件
        _cycleScrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    }
    [self addSubview:self.cycleScrollview];

}

@end
