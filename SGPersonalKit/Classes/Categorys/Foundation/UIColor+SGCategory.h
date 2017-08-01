//
//  UIColor+SGCategory.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SGCategory)

+ (UIColor *)colorWithInt:(int)color;


/**
 *  以#开头的字符串（不区分大小写），如：#ffFFff，若需要alpha，则传#abcdef255，不传默认为1
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithString:(NSString *)name;



@end
