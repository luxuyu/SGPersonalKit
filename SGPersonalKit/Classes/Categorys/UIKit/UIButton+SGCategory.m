//
//  UIButton+SGCategory.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/11.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "UIButton+SGCategory.h"
#define Activity_Tag   900001
#import <objc/runtime.h>

static const int block_key;

@interface _SGButtonBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _SGButtonBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end


@implementation UIButton (SGCategory)


- (void)setActionBlock:(void (^)(id sender))block {
    _SGButtonBlockTarget *target = [[_SGButtonBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:target action:@selector(invoke:) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void (^)(id)) actionBlock {
    _SGButtonBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}


+(UIButton*)createButtonWithTitle:(NSString*)title backgroundImage:(UIImage*)backgroundImage{
    return [[self class] createButtonWithTitle:title titleColor:nil image:nil backgroundImage:backgroundImage];
}

+(UIButton*)createButtonWithTitle:(NSString*)title titleColor:(UIColor*)color {
    return [[self class] createButtonWithTitle:title titleColor:color image:nil backgroundImage:nil];
    
}

+(UIButton*)createButtonWithTitle:(NSString*)title image:(UIImage*)image{
    return [[self class] createButtonWithTitle:title titleColor:nil image:image backgroundImage:nil];
}

+(UIButton*)createButtonWithImage:(UIImage*)image{
    return [[self class] createButtonWithTitle:nil titleColor:nil image:image backgroundImage:nil];
    
}

+(UIButton*)createButtonWithImage:(UIImage*)image backgroundImage:(UIImage*)backgroundImage{
    return [[self class] createButtonWithTitle:nil titleColor:nil image:image backgroundImage:backgroundImage];
    
}

+(UIButton*)createButtonWithBackgroundImage:(UIImage*)backgroundImage{
    return [[self class] createButtonWithTitle:nil titleColor:nil image:nil backgroundImage:backgroundImage];
}

+(UIButton*)createButtonWithTitle:(NSString*)title titleColor:(UIColor*)color image:(UIImage*)image backgroundImage:(UIImage*)backgroundImage{
    UIButton* button = [[self class] buttonWithType:UIButtonTypeCustom];
    [button setTitle:title titleColor:color forState:UIControlStateNormal];
    [button setImage:image bgImage:backgroundImage forState:UIControlStateNormal];
    [button sizeToFit];
    return button;
}

-(void)setNormalImage:(UIImage*)normalImage  selectedImage:(UIImage*)selectImage{
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:selectImage forState:UIControlStateSelected];
    [self setImage:selectImage forState:UIControlStateHighlighted];
}

-(void)setNormalBackgroundImage:(UIImage*)normalImage  selectedBackgroundImage:(UIImage*)selectImage{
    [self setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self setBackgroundImage:selectImage forState:UIControlStateSelected];
}

-(void)setNormalTitleColor:(UIColor *)normalColor  selectedTitleColor:(UIColor *)selectColor{
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:selectColor forState:UIControlStateSelected];
}

-(void)setTitle:(NSString*)title titleColor:(UIColor *)color forState:(UIControlState)state{
    [self setTitle:title titleColor:color image:nil bgImage:nil forState:state];
}

-(void)setImage:(UIImage*)image  bgImage:(UIImage*)bgImage forState:(UIControlState)state{
    [self setTitle:nil titleColor:nil image:image bgImage:bgImage forState:state];

}

-(void)setTitle:(NSString*)title titleColor:(UIColor *)color image:(UIImage*)image  bgImage:(UIImage*)bgImage forState:(UIControlState)state{
    if (title!= nil) {
        [self setTitle:title forState:state];
    }
    
    if (color != nil) {
        [self setTitleColor:color forState:state];
    }
    
    if (image != nil) {
        [self setImage:image forState:state];
    }
    
    if (bgImage != nil) {
        [self setBackgroundImage:image forState:state];
    }
}

-(void)hidesActivityView:(BOOL)hide{
    [self hidesActivityView:hide withStyle:UIActivityIndicatorViewStyleWhite];
}


-(void)hidesActivityView:(BOOL)hide withStyle:(UIActivityIndicatorViewStyle)style{
    [self setTitle:nil forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateSelected];
    [self setTitle:nil forState:UIControlStateHighlighted];
    [self setTitle:nil forState:UIControlStateDisabled];
    [self setAttributedTitle:nil forState:UIControlStateNormal];
    [self setAttributedTitle:nil forState:UIControlStateSelected];
    [self setAttributedTitle:nil forState:UIControlStateHighlighted];
    [self setAttributedTitle:nil forState:UIControlStateDisabled];
    
    if (hide == YES) {
        UIActivityIndicatorView * acti = (UIActivityIndicatorView *)[self viewWithTag:Activity_Tag];
        [acti removeFromSuperview];
    }
    else{
        UIActivityIndicatorView * acti = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height - 4, self.frame.size.height - 4)];
        acti.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        acti.tag = Activity_Tag;
        acti.activityIndicatorViewStyle = style;
        [self addSubview:acti];
        [acti startAnimating];

    }
    
}


- (void)sgTitleImageHorizontalAlignmentWithSpace:(float)space;
{
    [self resetEdgeInsets];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width+space, 0, -titleSize.width - space)];
}

- (void)sgImageTitleHorizontalAlignmentWithSpace:(float)space;
{
    [self resetEdgeInsets];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space, 0, -space)];
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
}

- (void)sgTitleImageVerticalAlignmentWithSpace:(float)space;
{
    [self verticalAlignmentWithTitleTop:YES space:space];
}

- (void)sgImageTitleVerticalAlignmentWithSpace:(float)space;
{
    [self verticalAlignmentWithTitleTop:NO space:space];
}

- (void)verticalAlignmentWithTitleTop:(BOOL)isTop space:(float)space ;
{
    [self resetEdgeInsets];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    float halfWidth = (titleSize.width + imageSize.width)/2;
    float halfHeight = (titleSize.height + imageSize.height)/2;
    
    float topInset = MIN(halfHeight, titleSize.height);
    float leftInset = (titleSize.width - imageSize.width)>0?(titleSize.width - imageSize.width)/2:0;
    float bottomInset = (titleSize.height - imageSize.height)>0?(titleSize.height - imageSize.height)/2:0;
    float rightInset = MIN(halfWidth, titleSize.width);
    
    if (isTop) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(-halfHeight-space, - halfWidth, halfHeight+space, halfWidth)];
        [self setContentEdgeInsets:UIEdgeInsetsMake(topInset+space, leftInset, -bottomInset, -rightInset)];
    } else {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(halfHeight+space, - halfWidth, -halfHeight-space, halfWidth)];
        [self setContentEdgeInsets:UIEdgeInsetsMake(-bottomInset, leftInset, topInset+space, -rightInset)];
    }
}

- (void)resetEdgeInsets
{
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
}
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color font:(UIFont*)font{
    [self hidesActivityView:YES];
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitleColor:mColor forState:UIControlStateNormal];

                [self setTitle:title forState:UIControlStateNormal];
                self.titleLabel.font = font;
                self.enabled = YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitleColor:color forState:UIControlStateNormal];
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.enabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

-(void)addUnderLine{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self.currentTitle];
    [attString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:(NSRange){0,[attString length]}];
    [attString addAttribute:NSForegroundColorAttributeName value:self.currentTitleColor range:(NSRange){0,[attString length]}];
    
    [self setAttributedTitle:attString forState:UIControlStateNormal];
}


@end
