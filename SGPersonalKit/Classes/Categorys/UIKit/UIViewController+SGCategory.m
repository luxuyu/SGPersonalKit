//
//  UIViewController+SGCategory.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "UIViewController+SGCategory.h"
#import <objc/runtime.h>
#import "Define.h"
#import "DefineNetwork.h"
#import "SGCategoryHeader.h"
@class KeyboardTap;

@interface UIViewController ()<UIGestureRecognizerDelegate>

@end

@implementation UIViewController (SGCategory)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        swizzleMethod(class, @selector(init), @selector(initSwizzled));
//        swizzleMethod(class, @selector(setTitle:), @selector(setTitleSwizzled:));
        swizzleMethod(class, @selector(preferredStatusBarStyle), @selector(sgPreferredStatusBarStyle));
        swizzleMethod(class, @selector(viewDidLoad), @selector(sgViewDidLoad));
        swizzleMethod(class, @selector(viewWillAppear:), @selector(sgViewWillAppear:));
        swizzleMethod(class, @selector(viewDidAppear:), @selector(sgViewDidAppear:));
        swizzleMethod(class, @selector(viewWillDisappear:), @selector(sgViewWillDisappear:));
        swizzleMethod(class, @selector(viewDidDisappear:), @selector(sgViewDidDisappear:));
        
    });
}


-(instancetype)initSwizzled{
    
    NSString* string = [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"nib"];
    
    if ([string isEmpty]) {
        self = [self initSwizzled];
    }
    else{
        self = [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
    }
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)sgViewDidLoad{
    NSString* string = [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"nib"];
    if ([string isEmpty]) {
        self.view.backgroundColor = Color_VC_BgColor;
    }
    [self sgViewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
#ifdef DEBUG
    
#else
    
#endif
    
}

-(BOOL)popGestureEnabled{
    return YES;
}

-(void)sgViewWillAppear:(BOOL)animated
{
    [self sgViewWillAppear:animated];
    
}
-(void)sgViewDidAppear:(BOOL)animated
{
    [self popGestureRecognizerEnabled:[self popGestureEnabled]];
    
    [self sgViewDidAppear:animated];
}
-(void)sgViewWillDisappear:(BOOL)animated
{
    [self sgViewWillDisappear:animated];
    
}

-(void)sgViewDidDisappear:(BOOL)animated
{
    [self popGestureRecognizerEnabled:NO];
    
    [self sgViewDidDisappear:animated];
    
}

-(UIStatusBarStyle)sgPreferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
#pragma mark - 自定义导航栏

-(void)navigationBarHidden:(BOOL)hidden{
    self.navigationController.navigationBarHidden = hidden;
    //    self.navigationController.navigationBar.hidden = hidden;
    
}
-(void)popGestureRecognizerEnabled:(BOOL)enable{
    
    if (self.navigationController.viewControllers.count == 1) {
        enable = NO;
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = enable;
    self.navigationController.interactivePopGestureRecognizer.delegate = enable == YES?self:nil;
    //    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}


-(void)setUpSingletonNavigationBar{
    [self navigationBarHidden:YES];
    
    UINavigationBar* navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kNavBarH)];
    [navigationBar setBackgroundImage:[UIImage createImageWithColor:Color_NavigationBar_Bg] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor] size:CGSizeMake(kScreenW, 0.5) ]];
    
    navigationBar.tag = NavigationBarTag;
    [self.view addSubview:navigationBar];
    
    UINavigationItem * customNavItem = [[UINavigationItem alloc] init];
    [navigationBar pushNavigationItem:customNavItem animated:YES];
    
}

- (UINavigationBar*)customNavBar{
    UINavigationBar * navigationBar = (UINavigationBar *)[self.view viewWithTag:NavigationBarTag];
    if (navigationBar == nil) {
        navigationBar = self.navigationController.navigationBar;
    }
    return navigationBar;
}

- (UINavigationItem *)customNavItem{
    if (self.customNavBar == self.navigationController.navigationBar) {
        return self.navigationItem;
    }
    return self.customNavBar.topItem;
}

//-(void)setTitleSwizzled:(NSString *)title{
//    if (![self isKindOfClass:[UIBaseViewController class]]) {
//        [self setTitleSwizzled:title];
//    }
//    [self setNavigationTitle:title];
//}
//
-(void)setNavigationTitle:(NSString *)title{
    self.customNavItem.titleView = ({
        CGSize size = [title sizeWithFont:Font_NavigationBar_Title sizeRange:CGSizeMake(kScreenW, 25)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        label.textColor = Color_NavigationBar_Title;
        label.font = Font_NavigationBar_Title;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = title;
        
        label;
    });
}

-(void)setNavigationTitleColor:(UIColor *)color{
    if (self.customNavBar == self.navigationController.navigationBar) {
        self.customNavBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    }
    else{
        UILabel * label = (UILabel *)self.customNavItem.titleView;
        label.textColor = color;
    }
    
}
#pragma mark - 设置左右BarButtonItem
-(void)popBack:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)close:(UIButton*)button{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(UIBarButtonItem *)backBarButtomItem{
    
    return [self backBarButtomItemWithSelector:@selector(popBack:)];
}
-(UIBarButtonItem *)backBarButtomItemWithSelector:(SEL)selector{
    
    return [self leftBarButtomItemWithImage:[UIImage imageNamed:@"public_nav_back"] selector:selector target:self];
}

-(UIBarButtonItem *)closeBarButtomItem{
    return [self closeBarButtomItemWithSelector:@selector(close:)];
}
-(UIBarButtonItem *)closeBarButtomItemWithSelector:(SEL)selector{
    return [self leftBarButtomItemWithImage:[UIImage imageNamed:@"public_nav_back"] selector:selector target:self];
    //    return [self leftBarButtomItemWithTitle:@"关闭" selector:selector target:self];
}

- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title selector:(SEL)selector target:(id)target{
    return [self leftBarButtomItemWithTitle:title titleColor:Color_NavigationBar_Item_Title selector:selector target:target];
}

- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color selector:(SEL)selector target:(id)target{
    return [self leftBarButtomItemWithTitle:title titleColor:color highLightTitleColor:nil selector:selector target:target];
}

- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor selector:(SEL)selector target:(id)target{
    return [self leftBarButtomItemWithTitle:title titleColor:color highLightTitleColor:highLightColor image:nil highLightImage:nil selector:selector target:target];
    
}

- (UIBarButtonItem *)leftBarButtomItemWithImage:(UIImage *)image selector:(SEL)selector target:(id)target{
    return [self leftBarButtomItemWithImage:image highLightImage:nil selector:selector target:target];
    
}

- (UIBarButtonItem *)leftBarButtomItemWithImage:(UIImage *)image highLightImage:(UIImage*)highLightImage selector:(SEL)selector target:(id)target{
    return [self leftBarButtomItemWithTitle:nil titleColor:nil highLightTitleColor:nil image:image highLightImage:highLightImage selector:selector target:target];
    
}

- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor image:(UIImage *)image highLightImage:(UIImage*)highLightImage  selector:(SEL)selector target:(id)target{
    
    UIButton* leftButton = [self createButtonWithTitle:title titleColor:color highLightTitleColor:highLightColor image:image highLightImage:highLightImage selector:selector target:target];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [leftButton sizeToFit];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UINavigationItem * naviItem = self.customNavItem;
    naviItem.leftBarButtonItem = leftItem;
    return leftItem;
}


//设置导航栏右边按钮
- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title selector:(SEL)selector target:(id)target{
    return [self rightBarButtomItemWithTitle:title titleColor:Color_NavigationBar_Item_Title selector:selector target:target];
}

- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color selector:(SEL)selector target:(id)target{
    return [self rightBarButtomItemWithTitle:title titleColor:color highLightTitleColor:nil selector:selector target:target];
}

- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor selector:(SEL)selector target:(id)target{
    return [self rightBarButtomItemWithTitle:title titleColor:color highLightTitleColor:highLightColor image:nil highLightImage:nil selector:selector target:target];
    
}

- (UIBarButtonItem *)rightBarButtomItemWithImage:(UIImage *)image selector:(SEL)selector target:(id)target{
    return [self rightBarButtomItemWithImage:image highLightImage:nil selector:selector target:target];
    
}

- (UIBarButtonItem *)rightBarButtomItemWithImage:(UIImage *)image highLightImage:(UIImage*)highLightImage selector:(SEL)selector target:(id)target{
    return [self rightBarButtomItemWithTitle:nil titleColor:nil highLightTitleColor:nil image:image highLightImage:highLightImage selector:selector target:target];
}

- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor image:(UIImage *)image highLightImage:(UIImage*)highLightImage  selector:(SEL)selector target:(id)target{
    UIButton * rightButton = [self createButtonWithTitle:title titleColor:color highLightTitleColor:highLightColor image:image highLightImage:highLightImage selector:selector target:target];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.customNavItem.rightBarButtonItem = rightItem;
    return rightItem;
}

-(UIButton*) createButtonWithTitle:(NSString *)title titleColor:(UIColor*)normalColor highLightTitleColor:(UIColor*)highLightColor image:(UIImage*)normalImage highLightImage:(UIImage *)highLightImage selector:(SEL)selector target:(id)target{
    UIButton *button = [UIButton createButtonWithTitle:title titleColor:normalColor image:normalImage backgroundImage:nil];
    [button setNormalImage:normalImage selectedImage:highLightImage];
    [button setTitle:title titleColor:normalColor forState:UIControlStateNormal];
    [button setTitle:title titleColor:highLightColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIViewController *)getCurrentVC{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    if ([topVC isKindOfClass:[UITabBarController class]]) {
        topVC = ((UITabBarController*)topVC).selectedViewController;
    }
    
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        topVC = ((UINavigationController*)topVC).viewControllers.lastObject;
    }
    
    return topVC;
//    return ShareApp.currentVC;

}

@end

@implementation KeyboardTap



@end

