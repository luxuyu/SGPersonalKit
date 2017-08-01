//
//  ShowTipManager.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/17.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "ShowTipManager.h"
#import "Define.h"
#define Delay_Second   2
@implementation ShowTipManager

//SHARE_SINGLE_CLASS(ShowTipManager)

+(void)showTip:(NSString*)title{
    if ([title length]<=0) {
        return;
//        title = @"好像哪里出错了~";
    }
    
    if (title.length > 10) {
        NSInteger count = title.length / 8.0 + Delay_Second;
        if (count > 10) {
            count = 10;
        }
        [ShowTipManager showTip:title withImage:nil withDelaySecond:count];

    }else{
        [ShowTipManager showTip:title withImage:nil];
    }
}

+ (void)showWarningTip:(NSString*)title{
    [ShowTipManager showTip:title withImage:[UIImage imageNamed:@"tip_warning"]];

}

+ (void)showDoneTip:(NSString*)title{
    [ShowTipManager showTip:title withImage:[UIImage imageNamed:@"tip_sure"]];

}

+ (void)showCollectionTip:(NSString*)title{
    [ShowTipManager showTip:title withImage:[UIImage imageNamed:@"tip_collection"]];
    
}

+(void)showTip:(NSString*)title withImage:(UIImage*)image
{
    [self showTip:title withImage:image withDelaySecond:Delay_Second];
}

+(void)showTip:(NSString*)title withDelaySecond:(NSTimeInterval)delaySecond{
    [self showTip:title withImage:nil withDelaySecond:Delay_Second];

}
+(void)showTip:(NSString*)title withImage:(UIImage*)image withDelaySecond:(NSTimeInterval)delaySecond{
    MBProgressHUD *myHud = [ShareApp.window viewWithTag:9888];
    
    if (myHud == nil) {
        myHud = [[MBProgressHUD alloc]initWithWindow:ShareApp.window];
        myHud.tag = 9888;
    }
    [ShareApp.window addSubview:myHud];
    
    myHud.mode =  MBProgressHUDModeCustomView;
    myHud.userInteractionEnabled = NO;
    myHud.labelText = title;
    if (image != nil) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 46, 46)];
        imageView.image = image;
        myHud.customView = imageView;
    }

    [myHud showAnimated:YES whileExecutingBlock:^{
        sleep(delaySecond);
    } completionBlock:^{
        [myHud removeFromSuperview];
        
    }];
}

+ (void)showLoadingViewInView:(UIView*)view{
    [ShowTipManager showLoadingViewWithTitle:nil inView:view];
}

+ (void)showLoadingViewWithTitle:(NSString*)title inView:(UIView*)view{
    
    MBProgressHUD *loadingHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    loadingHud.labelText = title;
//    [loadingHud showAnimated:YES whileExecutingBlock:^{
//        sleep(RequestTimeOutInSeconds);
//    } completionBlock:^{
//        [loadingHud removeFromSuperview];
//        
//    }];
    
}

+ (void)hideLoadingViewInView:(UIView*)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];

}

@end
