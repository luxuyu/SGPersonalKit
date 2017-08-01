//
//  DefineUI.h
//  MeiYueFuBusinessClient
//
//  Created by 拾光 on 2017/2/26.
//  Copyright © 2017年 丶拾光. All rights reserved.
//

#ifndef DefineUI_h
#define DefineUI_h

#define kScreenBounds   [[UIScreen mainScreen] bounds]

#define kScreenH   [[UIScreen mainScreen] bounds].size.height
#define kScreenW    [[UIScreen mainScreen] bounds].size.width

#define kScreenScale320   ((kScreenW/375.)>1?1:(kScreenW/375.))

#define kTabBarH    49
#define kNavBarH    64

#define Font_NavigationBar_Title   [UIFont boldSystemFontOfSize:17] //导航栏中间字体
#define Color_VC_BgColor            [UIColor colorWithInt:0xfff5f5f5]//视图背景默认颜色
#define Color_NavigationBar_Title   [UIColor colorWithInt:0xff080c00]//导航栏标题默认颜色
#define Color_NavigationBar_Item_Title   [UIColor colorWithInt:0xff080c00]//导航栏标题默认颜色
#define Color_NavigationBar_Bg      [UIColor colorWithInt:0xffffe430]//导航栏背景颜色

#endif /* DefineUI_h */
