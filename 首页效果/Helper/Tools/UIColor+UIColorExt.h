//
//  UIColor+UIColorExt.h
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorExt)

/**
 *
 *  下面的方法都是使用rgb值得到UIColor对象
 *
 *   @param  rgbValue the value of rgb
 *
 *
 *   @param  alpha  alpha for the color
 *
 *   @return a color
 *
 */

+ (UIColor *)colorFromRGB:(NSInteger)rgbValue withAlpha:(CGFloat)alpha;

+ (UIColor *)colorFromRGB:(NSInteger)rgbValue;

/**
 *
 *   下面的方法都是使用十六进制字符串得到UIColor对象
 *
 *    @param hexString 十六进制的字符串， 比如＃ffffff
 *
 *    param alpha      透明度
 *
 *    @return a color
 */

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexStringWithAlpha:(NSString *)hexString;

@end
