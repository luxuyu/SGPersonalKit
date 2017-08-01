//
//  UIScrollView+SGCategory.m
//  MeiYueFu
//
//  Created by 拾光 on 15/12/7.
//  Copyright © 2015年 拾光 All rights reserved.
//

#import "UIScrollView+SGCategory.h"
#import "Define.h"
#import "SGCategoryHeader.h"
#import "MJRefresh.h"
#import "RefreshHeaderView.h"
@implementation UIScrollView (SGCategory)

- (void)addPullDownToRefreshWithBlock:(void (^)(void))block {
    RefreshHeaderView * header = [RefreshHeaderView headerWithRefreshingBlock:^{
        
        if ([self.mj_footer isRefreshing] == YES) {
            [self.mj_footer endRefreshing];
        }
        block();
    }];
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"即将刷新" forState:MJRefreshStateWillRefresh];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor colorWithInt:0xff777777];
    
    self.mj_header = header;

}

- (void)addPullDownToRefreshWithClassName:(NSString *)className WithBlock:(void (^)(void))block {
    self.mj_header = [NSClassFromString(className) headerWithRefreshingBlock:^{
        
        if ([self.mj_footer isRefreshing] == YES) {
            [self.mj_footer endRefreshing];
        }
        block();
    }];
}

- (void)scrollToTopToRefresh{
    [self.mj_header beginRefreshing];
}

- (void)addPullUpToLoadMoreWithClassName:(NSString *)className WithBlock:(void (^)(void))block {
    self.mj_footer = [NSClassFromString(className) footerWithRefreshingBlock:^{
        if ([self.mj_header isRefreshing] == YES) {
            [self.mj_header endRefreshing];
        }
        block();
    }];
}

- (void)addPullUpToLoadMoreWithBlock:(void (^)(void))block {
    
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([self.mj_header isRefreshing] == YES) {
            [self.mj_header endRefreshing];
        }
        block();
    }];
    
    // 设置文字
    [footer setTitle:@"上拉加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor colorWithInt:0xff999999];
    self.mj_footer = footer;
}

-(void)stopRefreshing
{
    if ([self.mj_header isRefreshing] == YES) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing] == YES) {
        [self.mj_footer endRefreshing];
    }
    
}

-(void)noMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
    
}


-(void)resetNoMoreData{
    [self.mj_footer resetNoMoreData];
    
}

@end
