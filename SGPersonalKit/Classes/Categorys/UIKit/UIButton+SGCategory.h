//
//  UIButton+SGCategory.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/11.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SGCategory)

@property (nonatomic, copy) void (^actionBlock)(id);


+(UIButton*)createButtonWithTitle:(NSString*)title backgroundImage:(UIImage*)backgroundImage;
+(UIButton*)createButtonWithTitle:(NSString*)title titleColor:(UIColor*)color ;
+(UIButton*)createButtonWithTitle:(NSString*)title image:(UIImage*)image;

+(UIButton*)createButtonWithImage:(UIImage*)image;
+(UIButton*)createButtonWithImage:(UIImage*)image backgroundImage:(UIImage*)backgroundImage;
+(UIButton*)createButtonWithBackgroundImage:(UIImage*)backgroundImage;
+(UIButton*)createButtonWithTitle:(NSString*)title titleColor:(UIColor*)color image:(UIImage*)image backgroundImage:(UIImage*)backgroundImage;

-(void)setNormalImage:(UIImage*)normalImage  selectedImage:(UIImage*)selectImage;

-(void)setNormalBackgroundImage:(UIImage*)normalImage  selectedBackgroundImage:(UIImage*)selectImage;

-(void)setNormalTitleColor:(UIColor *)normalColor  selectedTitleColor:(UIColor *)selectColor;

-(void)setTitle:(NSString*)title titleColor:(UIColor *)color forState:(UIControlState)state;

-(void)setImage:(UIImage*)image  bgImage:(UIImage*)bgImage forState:(UIControlState)state;

-(void)setTitle:(NSString*)title titleColor:(UIColor *)color image:(UIImage*)image  bgImage:(UIImage*)bgImage forState:(UIControlState)state;


-(void)hidesActivityView:(BOOL)hide;
-(void)hidesActivityView:(BOOL)hide withStyle:(UIActivityIndicatorViewStyle)style;



- (void)sgTitleImageHorizontalAlignmentWithSpace:(float)space;
- (void)sgImageTitleHorizontalAlignmentWithSpace:(float)space;
- (void)sgTitleImageVerticalAlignmentWithSpace:(float)space;
- (void)sgImageTitleVerticalAlignmentWithSpace:(float)space;

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color font:(UIFont*)font;

-(void)addUnderLine;



@end
