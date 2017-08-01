//
//  UINavigationController+SGCategory.h
//  MeiYueFu
//
//  Created by 拾光 on 15/10/14.
//  Copyright © 2015年 拾光 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SGCategory)

//回退几个vc
-(void)popBackIndex:(NSInteger)index animate:(BOOL)animate;

@end
