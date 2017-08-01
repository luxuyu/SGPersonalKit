//
//  UITextField+SGCategory.m
//  ShouZuProject
//
//  Created by 拾光 on 2017/7/11.
//  Copyright © 2017年 丶拾光. All rights reserved.
//

#import "UITextField+SGCategory.h"

@implementation UITextField (SGCategory)
-(NSRange)selectRange{
    NSUInteger startPosition = [self offsetFromPosition:self.beginningOfDocument
                                                   toPosition:self.selectedTextRange.start];
    NSUInteger endPosition = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    NSRange range = NSMakeRange(startPosition, endPosition);
    return range;
}

@end
