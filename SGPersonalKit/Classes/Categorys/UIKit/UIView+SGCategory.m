//
//  UIView+SGCategory.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "UIView+SGCategory.h"
#import "UIColor+SGCategory.h"
#import "Define.h"
#import "SGCategoryHeader.h"
#define  ConversionRadian(degrees)    (( M_PI* (int)(degrees))/ 180)

@implementation UIView (SGCategory)

@dynamic sgTop;
@dynamic sgBottom;
@dynamic sgLeft;
@dynamic sgRight;

@dynamic sgX;
@dynamic sgY;
@dynamic sgOrigin;

@dynamic sgCenterX;
@dynamic sgCenterY;

@dynamic sgWidth;
@dynamic sgHeight;

@dynamic sgSize;


+(UIView*)getNibView{
    NSString * myName = [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [[[NSBundle mainBundle] loadNibNamed:myName owner:self options:nil] lastObject];
    
    
}

- (CGFloat)sgTop
{
    return self.frame.origin.y;
    
}

- (void)setSgTop:(CGFloat)sgTop{
    CGRect frame = self.frame;
    frame.origin.y = sgTop;
    self.frame = frame;
}

-(CGFloat)sgLeft
{
    return self.frame.origin.x;
}

- (void)setSgLeft:(CGFloat)sgLeft{
    
    CGRect frame = self.frame;
    frame.origin.x = sgLeft;
    self.frame = frame;
}

- (CGFloat)sgBottom{
    return self.frame.size.height + self.frame.origin.y;
    
}

- (void)setSgBottom:(CGFloat)sgBottom{
    CGRect frame = self.frame;
    frame.origin.y = sgBottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)sgRight{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setSgRight:(CGFloat)sgRight{
    CGRect frame = self.frame;
    frame.origin.x = sgRight - frame.size.width;
    self.frame = frame;
}

- (CGFloat)sgX{
    return self.frame.origin.x;
}

- (void)setSgX:(CGFloat)sgX{
    
    CGRect frame = self.frame;
    frame.origin.x = sgX;
    self.frame = frame;
}

- (CGFloat)sgY{
    return self.frame.origin.y;
}

- (void)setSgY:(CGFloat)sgY{
    CGRect frame = self.frame;
    frame.origin.y = sgY;
    self.frame = frame;
}

- (CGPoint)sgOrigin{
    return self.frame.origin;
}

- (void)setSgOrigin:(CGPoint)sgOrigin{
    CGRect frame = self.frame;
    frame.origin = sgOrigin;
    self.frame = frame;
}

- (CGFloat)sgCenterX{
    return self.center.x;
}

- (void)setSgCenterX:(CGFloat)sgCenterX{
    CGPoint center = self.center;
    center.x = sgCenterX;
    self.center = center;
}


- (CGFloat)sgCenterY{
    return self.center.y;
}

- (void)setSgCenterY:(CGFloat)sgCenterY{
    CGPoint center = self.center;
    center.y = sgCenterY;
    self.center = center;
}

- (CGFloat)sgWidth{
    
    return self.frame.size.width;
}

- (void)setSgWidth:(CGFloat)sgWidth{
    CGRect frame = self.frame;
    frame.size.width = sgWidth;
    self.frame = frame;
}

- (CGFloat)sgHeight
{
    return self.frame.size.height;
}

- (void)setSgHeight:(CGFloat)sgHeight
{
    CGRect frame = self.frame;
    frame.size.height = sgHeight;
    self.frame = frame;
}

- (CGSize)sgSize{
    
    return self.frame.size;
}

-(void)setSgSize:(CGSize)sgSize{
    CGRect frame = self.frame;
    frame.size = sgSize;
    self.frame = frame;
}



-(void)clickDiggAnimation{
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    
    [self.layer addAnimation:k forKey:@"SHOW"];
}


-(void)setLayerCornerRadius:(CGFloat)Radius
{
    [self setLayerBorderColor:nil width:0 cornerRadius:Radius];
}

-(void)setLayerBorderColor:(UIColor*)color width:(CGFloat)width
{
    [self setLayerBorderColor:color width:width cornerRadius:0];
}

-(void)setLayerBorderColor:(UIColor*)color width:(CGFloat)width cornerRadius:(CGFloat)Radius
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = Radius;
}

-(void)setLayerShadowPath{
    [self setLayerShadowPathWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
}

-(void)setLayerShadowPathWithColor:(UIColor*)color{
    [self setLayerShadowPathWithColor:color withOffset:CGSizeMake(0.5, 0)];
}

-(void)setLayerShadowPathWithWidth:(CGFloat)width{
    [self setLayerShadowPathWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] withOffset:CGSizeMake(0, 0) withWidth:3];

}

-(void)setLayerShadowPathWithColor:(UIColor*)color withOffset:(CGSize)offset {
    [self setLayerShadowPathWithColor:color withOffset:offset withWidth:2];

}

-(void)setLayerShadowPathWithColor:(UIColor*)color withOffset:(CGSize)offset withWidth:(CGFloat)width
{
    if (color == nil) {
        color = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    self.layer.shadowColor = [color CGColor];
    self.layer.shadowOffset = offset;
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius = width;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    CGRect bounds = self.bounds ;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
    
    self.layer.shadowPath = path.CGPath;
}


- (void)drawDashLineLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithFloat:lineLength], [NSNumber numberWithFloat:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

//
- (void)drawDashCircleLineWidth:(CGFloat)width length:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor
{

    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:(self.frame.size.width -width)/2 startAngle:ConversionRadian(0)  endAngle:ConversionRadian(360) clockwise:1].CGPath;
    arc.fillColor = [UIColor clearColor].CGColor;
    arc.strokeColor = [UIColor purpleColor].CGColor;
    arc.lineWidth = width;
    [arc setLineDashPattern:[NSArray arrayWithObjects:@(lineLength),@(lineSpacing),nil]];
    CAGradientLayer * layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    layer.colors = @[(__bridge id)lineColor.CGColor,(__bridge id)lineColor.CGColor];
    layer.startPoint = CGPointMake(0,0.5);
    layer.endPoint = CGPointMake(1,0.5);
    layer.mask = arc;
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:layer];
}




-(UIView*)addLineToTop{
    return [self addLineToTopWithColor:Color_Line WithHeight:0.5];

}
-(UIView*)addLineToTopWithColor:(UIColor*)color{
    return [self addLineToTopWithColor:color WithHeight:0.5];
}
-(UIView*)addLineToTopWithColor:(UIColor*)color WithHeight:(CGFloat)height{
    UIView * line = [self viewWithTag:TopLineTag];
    if (line == nil) {
        line = [[UIView alloc] init];
    }
    line.tag = TopLineTag;
    line.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    line.backgroundColor = color;
    [self addSubview:line];
    return line;

}
-(UIView*)addLineToBottom{
    return [self addLineToBottomWithColor:Color_Line WithHeight:0.5];
}

-(UIView*)addLineToBottomWithOrigin:(CGPoint)point{
    return [self addLineToBottomWithColor:Color_Line WithHeight:0.5 WithOrigin:point];

}

-(UIView*)addLineToBottomWithColor:(UIColor*)color{
    return [self addLineToBottomWithColor:color WithHeight:0.5];
}
-(UIView*)addLineToBottomWithColor:(UIColor*)color WithHeight:(CGFloat)height{
    return [self addLineToBottomWithColor:color WithHeight:height
                             WithOrigin:CGPointMake(0, self.frame.size.height - height)];
}


-(UIView*)addLineToBottomWithColor:(UIColor*)color WithHeight:(CGFloat)height WithOrigin:(CGPoint)point{
    UIView * line = [self viewWithTag:BottomLineTag];
    if (line == nil) {
        line = [[UIView alloc] init];
    }
    line.tag = BottomLineTag;

    line.frame = CGRectMake(point.x, point.y - height, [UIScreen mainScreen].bounds.size.width, height);
    line.backgroundColor = color;
    [self addSubview:line];
    return line;

}
-(UIView*)addLineToViewWithFrame:(CGRect)rect WithTag:(NSInteger)tag{
    return [self addLineToViewWithColor:Color_Line WithFrame:rect WithTag:tag];
}

-(UIView*)addLineToViewWithColor:(UIColor*)color WithFrame:(CGRect)rect   WithTag:(NSInteger)tag{
    UIView * line = [self viewWithTag:tag];
    if (line == nil) {
        line = [[UIView alloc] init];
    }
    line.tag = tag;
    line.frame = rect;
    line.backgroundColor = color;
    [self addSubview:line];
    return line;
}

-(void)removeTopLine{
    UIView * line = [self viewWithTag:TopLineTag];
    if (line != nil) {
        [line removeFromSuperview];
        [self removeTopLine];

    }

}
-(void)removeBottomLine{
    UIView * line = [self viewWithTag:BottomLineTag];
    if (line != nil) {
        [line removeFromSuperview];
        [self removeBottomLine];
    }
}


-(UITapGestureRecognizer*)addTapGestureRecognizer:(id)target action:(SEL)selector {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    
    [self addGestureRecognizer:tap];
    return tap;
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

-(void)addRemindButton:(CGRect)frame actionBlock:(void(^)(UIButton * button))block{
    UIButton * button = [self viewWithTag:RemindButtonTag];

    if (button == nil) {
        button = [UIButton createButtonWithImage:[UIImage imageNamed:@"public_remind"]];
        button.tag = RemindButtonTag;
        [self addSubview:button];
    }
    button.frame = frame;
    [button setActionBlock:block];
}

-(void)removeRemindButton{
    UIButton * button = [self viewWithTag:RemindButtonTag];
    if (button != nil) {
        [button removeFromSuperview];
    }
}


@end
