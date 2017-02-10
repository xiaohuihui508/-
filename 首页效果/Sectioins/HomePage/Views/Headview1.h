//
//  Headview1.h
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"


@interface Headview1 : UICollectionReusableView

@property (nonatomic, strong) SDCycleScrollView *cycleScrollview;

- (void)cellReusableViewHeaderImageArray:(NSArray *)imageArr;

@end
