//
//  NSObject+SGCategory.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "NSObject+SGCategory.h"
#import <objc/runtime.h>
@implementation NSObject (SGCategory)

-(BOOL)isEmpty{

    if (self == nil|| self == [NSNull null]) {
        return true;
    }
    
    if([self isKindOfClass:[NSString class]]){
        NSString* str = (NSString*)self;
        return [str length]==0;
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        NSArray* ary = (NSArray*)self;
        return [ary count]==0;
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dir = (NSDictionary*)self;
        return [dir count]==0;
    }
    return NO;
}


- (void)performAfterDelay:(NSTimeInterval)delay block:(void(^)())block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (delay * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
            
        });
    });
    
}

- (void)async:(void(^)())block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        block();
    });
}


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
