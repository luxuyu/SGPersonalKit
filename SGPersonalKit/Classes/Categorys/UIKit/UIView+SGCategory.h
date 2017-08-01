//
//  UIView+SGCategory.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TopLineTag   6001
#define BottomLineTag   6002
#define RemindButtonTag   6101
#define Color_Line   [UIColor colorWithInt:0x1e000000]

@interface UIView (SGCategory)

+(UIView*)getNibView;

@property (assign, nonatomic) CGFloat    sgTop;
@property (assign, nonatomic) CGFloat    sgBottom;
@property (assign, nonatomic) CGFloat    sgLeft;
@property (assign, nonatomic) CGFloat    sgRight;

@property (assign, nonatomic) CGFloat    sgX;
@property (assign, nonatomic) CGFloat    sgY;
@property (assign, nonatomic) CGPoint    sgOrigin;

@property (assign, nonatomic) CGFloat    sgCenterX;
@property (assign, nonatomic) CGFloat    sgCenterY;

@property (assign, nonatomic) CGFloat    sgWidth;
@property (assign, nonatomic) CGFloat    sgHeight;
@property (assign, nonatomic) CGSize     sgSize;


//点赞效果
-(void)clickDiggAnimation;

/**
 *  设置view的圆角角度
 *
 *  @param Radius 圆角角度
 */
-(void)setLayerCornerRadius:(CGFloat)Radius;

/**
 *  设置view的描边颜色及描边宽度
 *
 *  @param color 描边颜色
 *  @param width 描边宽度
 */
-(void)setLayerBorderColor:(UIColor*)color width:(CGFloat)width ;

/**
 *  设置view 描边颜色、描边宽度及圆角角度
 *
 *  @param color  描边颜色
 *  @param width  描边宽度
 *  @param Radius 圆角角度
 */
-(void)setLayerBorderColor:(UIColor*)color width:(CGFloat)width cornerRadius:(CGFloat)Radius;

-(void)setLayerShadowPath;
-(void)setLayerShadowPathWithColor:(UIColor*)color;
-(void)setLayerShadowPathWithWidth:(CGFloat)width;
-(void)setLayerShadowPathWithColor:(UIColor*)color withOffset:(CGSize)offset;
-(void)setLayerShadowPathWithColor:(UIColor*)color withOffset:(CGSize)offset withWidth:(CGFloat)width;

//画虚线
- (void)drawDashLineLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor;
- (void)drawDashCircleLineWidth:(CGFloat)width length:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor;


-(UIView*)addLineToTop;
-(UIView*)addLineToTopWithColor:(UIColor*)color;
-(UIView*)addLineToTopWithColor:(UIColor*)color WithHeight:(CGFloat)height;
-(UIView*)addLineToBottom;
-(UIView*)addLineToBottomWithOrigin:(CGPoint)point;
-(UIView*)addLineToBottomWithColor:(UIColor*)color;
-(UIView*)addLineToBottomWithColor:(UIColor*)color WithHeight:(CGFloat)height;
-(UIView*)addLineToBottomWithColor:(UIColor*)color WithHeight:(CGFloat)height WithOrigin:(CGPoint)point;
-(UIView*)addLineToViewWithFrame:(CGRect)rect WithTag:(NSInteger)tag;
-(UIView*)addLineToViewWithColor:(UIColor*)color WithFrame:(CGRect)rect WithTag:(NSInteger)tag;

-(void)removeTopLine;
-(void)removeBottomLine;

-(UITapGestureRecognizer*)addTapGestureRecognizer:(id)target action:(SEL)selector ;

- (UIView *)findFirstResponder;

-(void)addRemindButton:(CGRect)frame actionBlock:(void(^)(UIButton * button))block;
-(void)removeRemindButton;
@end
