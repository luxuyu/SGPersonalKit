//
//  UILabel+SGCategory.h
//  MeiYueFu
//
//  Created by 拾光 on 15/10/22.
//  Copyright © 2015年 拾光 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SGCategory)

-(void)setAttriStringColor:(UIColor*)color inRange:(NSRange)range font:(UIFont*)font;
-(void)setAttriStringEndLength:(NSInteger)length color:(UIColor*)color font:(UIFont*)font;

@end
