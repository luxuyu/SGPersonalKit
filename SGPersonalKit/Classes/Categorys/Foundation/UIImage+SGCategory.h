//
//  UIImage+SGCategory.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SGCategory)

+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size ;


+ (UIImage*)conductImage:(UIImage*)image;

+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;






@end
