//
//  UILabel+SGCategory.m
//  MeiYueFu
//
//  Created by 拾光 on 15/10/22.
//  Copyright © 2015年 拾光 All rights reserved.
//

#import "UILabel+SGCategory.h"

@implementation UILabel (SGCategory)

-(void)setAttriStringColor:(UIColor*)color inRange:(NSRange)range font:(UIFont*)font
{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self.text];
    if (color != nil) {
        [attriString addAttribute:NSForegroundColorAttributeName
                            value:(id)color
                            range:range];
    }
    
    if (font != nil) {
        [attriString addAttribute:NSFontAttributeName
                            value:(id)font
                            range:range];
    }

    
    self.attributedText = attriString;
}


-(void)setAttriStringEndLength:(NSInteger)length color:(UIColor*)color font:(UIFont*)font{
    [self setAttriStringColor:color inRange:NSMakeRange(self.text.length - length, length) font:font];
    
}

@end
