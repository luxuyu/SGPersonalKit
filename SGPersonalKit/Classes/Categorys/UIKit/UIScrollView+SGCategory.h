//
//  UIScrollView+SGCategory.h
//  MeiYueFu
//
//  Created by 拾光 on 15/12/7.
//  Copyright © 2015年 拾光 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SGCategory)
- (void)addPullDownToRefreshWithBlock:(void (^)(void))block ;

- (void)addPullDownToRefreshWithClassName:(NSString*)className WithBlock:(void (^)(void))block ;

- (void)addPullUpToLoadMoreWithBlock:(void (^)(void))block ;

- (void)addPullUpToLoadMoreWithClassName:(NSString*)className WithBlock:(void (^)(void))block ;

- (void)scrollToTopToRefresh;

- (void)stopRefreshing;

- (void)noMoreData;

- (void)resetNoMoreData;


@end
