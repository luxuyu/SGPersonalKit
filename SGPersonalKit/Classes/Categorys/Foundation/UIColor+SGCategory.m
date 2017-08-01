//
//  UIColor+SGCategory.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "UIColor+SGCategory.h"

@implementation UIColor (SGCategory)

+ (UIColor *)colorWithInt:(int)color
{
    
    CGFloat a = ((color & 0xFF000000) >> (3 * 8))/255.0;
    CGFloat r = ((color & 0x00FF0000) >> (2 * 8))/255.0;
    CGFloat g = ((color & 0x0000FF00) >> (1 * 8))/255.0;
    CGFloat b = ((color & 0x000000FF) >> (0 * 8))/255.0;
    
    UIColor * c = [UIColor colorWithRed:r green:g blue:b alpha:a];
    return c;
}


+ (UIColor *)colorWithString:(NSString *)name
{
    if (![[name substringToIndex:0] isEqualToString:@"#"] && name.length < 7) {
        return nil;
    }
    const char *str = [[name substringWithRange:NSMakeRange(1, 6)] UTF8String];
    NSString *alphaString = [name substringFromIndex:7];
    CGFloat red = (convertToInt(str[0])*16 + convertToInt(str[1])) / 255.0f;
    CGFloat green = (convertToInt(str[2])*16 + convertToInt(str[3])) / 255.0f;
    CGFloat blue = (convertToInt(str[4])*16 + convertToInt(str[5])) / 255.0f;
    CGFloat alpha = [alphaString isEqualToString:@""] ? 1 : alphaString.floatValue/255;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

int convertToInt(char c)
{
    if (c >= '0' && c <= '9') {
        return c - '0';
    } else if (c >= 'a' && c <= 'f') {
        return c - 'a' + 10;
    } else if (c >= 'A' && c <= 'F') {
        return c - 'A' + 10;
    } else {
        return printf("字符非法!");
    }
}

@end
