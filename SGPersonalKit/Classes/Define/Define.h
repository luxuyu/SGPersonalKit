//
//  Define.h
//  MeiYueFuBusinessClient
//
//  Created by 拾光 on 2017/2/26.
//  Copyright © 2017年 丶拾光. All rights reserved.
//

#ifndef Define_h
#define Define_h

#import "DefineUI.h"
#define Application     [UIApplication sharedApplication]
#define ShareApp       ([Application delegate])
#define NotiCenter     [NSNotificationCenter defaultCenter]
#define UserDefault     [NSUserDefaults standardUserDefaults]
#define IOSVersion     [[[UIDevice currentDevice] systemVersion] floatValue]

#define kNotificationScreenTouch             @"kNotificationScreenTouch"


//应用版本号
#define AppVersionStr [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] //build
#define AppVersionShortStr [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]//version

/** 创建单例的宏 */
#define SHARE_SINGLE_CLASS_HEADER(classname)                                \
\
+ (classname *)shared##classname;

#define SHARE_SINGLE_CLASS(classname)                                       \
\
static classname *shared##classname = nil;                                  \
\
+ (classname *)shared##classname                                            \
{                                                                           \
static dispatch_once_t pred;                                                \
dispatch_once(&pred, ^{ shared##classname = [[classname alloc] init]; });   \
return shared##classname;                                                   \
}

//DEBUG  模式下打印日志,当前行
#ifndef __OPTIMIZE__
//#   define DLog(fmt, ...) fprintf((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define DLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define DLog(fmt, ...) NSLog((@"\nfunction:%s [Line %d]" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif

#define dispatch_main_sync(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#endif /* Define_h */
