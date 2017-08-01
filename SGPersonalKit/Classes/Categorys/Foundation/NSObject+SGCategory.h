//
//  NSObject+SGCategory.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AfterDelay   0.25

@interface NSObject (SGCategory)

-(BOOL)isEmpty;

/**
 *  延长delay秒之后执行block中的代码
 *
 *  @param delay 延长秒数
 *  @param block 代码块
 */
- (void)performAfterDelay:(NSTimeInterval)delay block:(void(^)())block;

- (void)async:(void(^)())block;

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) ;

@end
