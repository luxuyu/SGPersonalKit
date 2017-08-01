//
//  UINavigationController+SGCategory.m
//  MeiYueFu
//
//  Created by 拾光 on 15/10/14.
//  Copyright © 2015年 拾光 All rights reserved.
//

#import "UINavigationController+SGCategory.h"
#import "SGCategoryHeader.h"
@implementation UINavigationController (SGCategory)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([self class], @selector(popViewControllerAnimated:), @selector(sgpopViewControllerAnimated:));
    });
}

+(void)initialize{
    
    UINavigationBar * navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage createImageWithColor:Color_NavigationBar_Bg] forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[UIImage createImageWithColor:[UIColor colorWithInt:0xffe0e0e0] size:CGSizeMake(kScreenW, 0.5) ]];
    [navBar setShadowImage:[[UIImage alloc] init]];
//
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:Color_NavigationBar_Title,NSFontAttributeName:Font_NavigationBar_Title};
//    navBar.barTintColor = Color_NavigationBar_Item_Title;
    navBar.tintColor = Color_NavigationBar_Item_Title;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


-(UIViewController *)sgpopViewControllerAnimated:(BOOL)animated{
    return [self sgpopViewControllerAnimated:animated];

//    if (self.viewControllers.count <= 1) {
//        return [self sgpopViewControllerAnimated:YES];
//    }
//    NSInteger selfIndex = self.viewControllers.count -1;
//    UIViewController * vc = [self.viewControllers objectAtIndex:selfIndex -1];
//    if ([vc isKindOfClass:[UIBaseViewController class]]) {
//        UIBaseViewController * baseVC = (UIBaseViewController*)vc;
//        while (baseVC.canNotGoBack == YES) {
//            
//            NSInteger index = [self.viewControllers indexOfObject:baseVC];
//            if (index >0) {
//                baseVC = [self.viewControllers objectAtIndex:index -1];
//                if (![baseVC isKindOfClass:[UIBaseViewController class]]) {
//                    [self popToViewController:baseVC animated:animated];
//                    return baseVC;
//                }
//            }else{
//                [self popToViewController:baseVC animated:animated];
//                return baseVC;
//
//            }
//        }
//        [self popToViewController:baseVC animated:animated];
//        return baseVC;
//    }
//    
//    [self popToViewController:vc animated:animated];
//    return vc;
}

-(void)popBackIndex:(NSInteger)index animate:(BOOL)animate{
    
    if (self.viewControllers.count <= index) {
        index = self.viewControllers.count -1;
    }
    UIViewController * vc = [self.viewControllers objectAtIndex:self.viewControllers.count - index -1];
    [self popToViewController:vc animated:animate];
    
}


@end
