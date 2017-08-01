//
//  RefreshHeaderView.m
//  MeiYueFu
//
//  Created by 拾光 on 16/1/22.
//  Copyright © 2016年 拾光 All rights reserved.
//

#import "RefreshHeaderView.h"

@implementation RefreshHeaderView

- (void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=1; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_animation_img_%zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
//    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_animation_img_%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
//    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.center = CGPointMake(self.stateLabel.center.x, self.frame.size.height/2);
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 65;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}


//- (void)setPullingPercent:(CGFloat)pullingPercent
//{
//    [super setPullingPercent:pullingPercent];
//    if (pullingPercent != 0) {
//        if (pullingPercent < 0.2) {
//            pullingPercent = 0.2;
//        }
//        if (pullingPercent > 0.8) {
//            pullingPercent = 0.8;
//        }
//        self.gifView.transform = CGAffineTransformMakeScale(pullingPercent, pullingPercent);
//    }
//}

@end
