//
//  ShowTipManager.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/17.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ShowTipManager : NSObject

+(void)showTip:(NSString*)title ;
+ (void)showWarningTip:(NSString*)title;
+ (void)showDoneTip:(NSString*)title;
+ (void)showTip:(NSString*)title withImage:(UIImage*)image;
+(void)showTip:(NSString*)title withDelaySecond:(NSTimeInterval)delaySecond;

+ (void)showCollectionTip:(NSString*)title;


+ (void)showLoadingViewWithTitle:(NSString*)title inView:(UIView*)view;
+ (void)showLoadingViewInView:(UIView*)view;

+ (void)hideLoadingViewInView:(UIView*)view;

@end
