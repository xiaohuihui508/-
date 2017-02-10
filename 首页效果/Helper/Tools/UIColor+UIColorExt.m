//
//  UIColor+UIColorExt.m
//  首页效果
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIColor+UIColorExt.h"

@implementation UIColor (UIColorExt)

//RGB
+ (UIColor *)colorFromRGB:(NSInteger)rgbValue withAlpha:(CGFloat)alpha {
    return [UIColor colorWithDisplayP3Red:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0
                                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0
                                     blue:((float)(rgbValue & 0xFF)) / 255.0
                                    alpha:alpha];
}

+ (UIColor *)colorFromRGB:(NSInteger)rgbValue {
    return [UIColor colorWithDisplayP3Red:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0
                                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0
                                     blue:((float)(rgbValue & 0xFF)) / 255.0
                                    alpha:1.0f];
}

//十六进制的数  eg.#ff0000

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [UIColor colorWithHexString:hexString alpha:1.0f];
}

//十六进制的数  eg.#ffffff
+ (UIColor *)colorWithHexStringWithAlpha:(NSString *)hexString {
    if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
        hexString = [hexString substringFromIndex:2];
    } else if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    unsigned int value = 0;
    BOOL flag = [[NSScanner scannerWithString:hexString] scanHexInt:&value];
    
    if (NO == flag)
        return [UIColor clearColor];
    float r,g,b,a;
    a = (value & 0x000000FF) / 255.0;
    value = value >> 8;
    b = value & 0x000000FF;
    value = value >> 8;
    g = value & 0x000000FF;
    value = value >> 8;
    r = value;
    
    return [UIColor colorWithDisplayP3Red:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    
    if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
        hexString = [hexString substringFromIndex:2];
    } else if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    unsigned int value = 0;
    BOOL flag = [[NSScanner scannerWithString:hexString] scanHexInt:&value];
    if (NO == flag)
        return [UIColor clearColor];
    
    float r,g,b,a;
    a = alpha;
    b = value & 0x0000FF;
    value = value >> 8;
    g = value & 0x0000FF;
    value = value >> 8;
    r = value;
    
    return [UIColor colorWithDisplayP3Red:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a];
    
}

@end
