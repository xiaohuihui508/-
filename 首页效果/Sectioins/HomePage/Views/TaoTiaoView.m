//
//  TaoTiaoView.m
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TaoTiaoView.h"

@implementation TaoTiaoView{
    __weak IBOutlet UILabel *lab1;
    __weak IBOutlet UILabel *lab2;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void)setData:(NSString *)str1 str:(NSString *)str2 {
    lab1.text = str1;
    lab2.text = str2;
}

@end
