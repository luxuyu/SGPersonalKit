//
//  UINavigationBar+SGCategory.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/7/27.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "UINavigationBar+SGCategory.h"
#import <CoreGraphics/CoreGraphics.h>
#import "Define.h"
@implementation UINavigationBar (SGCategory)

- (void)DrawGradientOptions:(CGGradientDrawingOptions) options
               startColor:(UIColor*)startColor
                 endColor:(UIColor*)endColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor* colors [2] = {startColor,endColor};
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colorComponents[8];
    
    for (int i = 0; i < 2; i++) {
        UIColor *color = colors[i];
        CGColorRef temcolorRef = color.CGColor;
        
        const CGFloat *components = CGColorGetComponents(temcolorRef);
        for (int j = 0; j < 4; j++) {
            colorComponents[i * 4 + j] = components[j];
        }
    }
    
    CGGradientRef gradient =  CGGradientCreateWithColorComponents(rgb, colorComponents, NULL, 2);
    
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(64, kScreenW), options);
    CGGradientRelease(gradient);
}

@end
