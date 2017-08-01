//
//  DeviceModel.m
//  MeiYueFu
//
//  Created by 拾光 on 2016/11/9.
//  Copyright © 2016年 拾光 All rights reserved.
//

#import "DeviceModel.h"
#import "SAMKeychain.h"
#import <UIKit/UIKit.h>
@implementation DeviceModel

+(NSString*)deviceID{
    
    NSString * deviceid = [SAMKeychain passwordForService:@"com.meiyuefu" account:@"meiyuefu"];
    if (deviceid.length == 0) {
        deviceid =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SAMKeychain setPassword:deviceid forService:@"com.meiyuefu" account:@"meiyuefu"];
        
    }
    return deviceid;
}

@end
