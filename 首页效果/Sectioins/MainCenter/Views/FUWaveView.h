//
//  FUWaveView.h
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUWaveView : UIImageView

- (instancetype)initWithFrame:(CGRect)frame
                        Image:(NSString *)imageName
                   centerIcon:(NSString *)icon;

- (void)starWave;

- (void)stopWave;

@end
