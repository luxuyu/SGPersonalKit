//
//  NSAttributedString+SGCategory.m
//  ShouZuProject
//
//  Created by 拾光 on 2017/7/14.
//  Copyright © 2017年 丶拾光. All rights reserved.
//

#import "NSMutableAttributedString+SGCategory.h"

@implementation NSMutableAttributedString (SGCategory)

- (void)setLineSpace:(CGFloat)space{
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = space; //设置行间距
    
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];
    
}


@end
