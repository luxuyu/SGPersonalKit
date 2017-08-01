//
//  UIViewController+SGCategory.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "SGCategoryHeader.h"

#define NavigationBarTag  9009  
@class KeyboardTap;
@interface UIViewController (SGCategory)


#pragma mark - 自定义导航栏
-(void)navigationBarHidden:(BOOL)hidden;
-(void)popGestureRecognizerEnabled:(BOOL)enable;
-(void)setUpSingletonNavigationBar;
- (UINavigationBar*)customNavBar;
- (UINavigationItem *)customNavItem;

-(void)setNavigationTitle:(NSString *)title;
-(void)setNavigationTitleColor:(UIColor *)color;

#pragma mark - 自定义导航栏barbutton
#pragma mark  设置左导航栏barbutton
-(void)close:(UIButton*)button;
-(void)popBack:(UIButton*)button;

-(UIBarButtonItem *)backBarButtomItem;
-(UIBarButtonItem *)backBarButtomItemWithSelector:(SEL)selector;

-(UIBarButtonItem *)closeBarButtomItem;
-(UIBarButtonItem *)closeBarButtomItemWithSelector:(SEL)selector;

- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)leftBarButtomItemWithImage:(UIImage *)image selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)leftBarButtomItemWithImage:(UIImage *)image highLightImage:(UIImage*)highLightImage selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)leftBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor image:(UIImage *)image highLightImage:(UIImage*)highLightImage  selector:(SEL)selector target:(id)target;
#pragma mark  设置右导航栏barbutton
- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)rightBarButtomItemWithImage:(UIImage *)image selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)rightBarButtomItemWithImage:(UIImage *)image highLightImage:(UIImage*)highLightImage selector:(SEL)selector target:(id)target;
- (UIBarButtonItem *)rightBarButtomItemWithTitle:(NSString *)title titleColor:(UIColor*)color highLightTitleColor:(UIColor*)highLightColor image:(UIImage *)image highLightImage:(UIImage*)highLightImage  selector:(SEL)selector target:(id)target;




-(UIButton*) createButtonWithTitle:(NSString *)title titleColor:(UIColor*)normalColor highLightTitleColor:(UIColor*)highLightColor image:(UIImage*)normalImage highLightImage:(UIImage *)highLightImage selector:(SEL)selector target:(id)target;


+ (UIViewController *)getCurrentVC;

@end


@interface KeyboardTap : UITapGestureRecognizer

@property (nonatomic, assign) NSInteger tag;

@end
