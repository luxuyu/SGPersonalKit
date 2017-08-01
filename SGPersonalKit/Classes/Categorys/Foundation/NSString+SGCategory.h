//
//  NSString+SGCategory.h
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (SGCategory)

-(NSString*)conciseFloatStr;

//加一条中间的划线
-(NSAttributedString*)strikeThroughLineWithColor:(UIColor*)color;

- (NSMutableAttributedString*)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;


-(NSString*)moneyStr;
/**
 *  判断是否纯数字
 *
 *  @return 是 或者 不是
 */
- (BOOL)isNumText;

/**
 *  判断是否手机号
 *
 *  @return 是不是
 */
- (BOOL)isAValidChinaMobileNumber;

/**
 *  计算中英文混合字符串的字节长度  中文两字节 英文一字节
 *
 *  @return 字节长度
 */
-(NSUInteger) unicodeLength;


/**
 *  计算字符串size
 *
 *  @param font 字体
 *  @param size size范围
 *
 *  @return 计算后的size
 */
- (CGSize)sizeWithFont:(UIFont *)font sizeRange:(CGSize)size;


/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email;

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile;

/*判断是否只有中英文*/
+(BOOL)isLetterAndChinese:(NSString*)text;

-(BOOL)isChinese:(NSString*)text;



#pragma 正则匹配手机号
- (BOOL)checkTelNumber;
#pragma 正则匹配用户密码6-12位数字和字母组合
- (BOOL)checkPassword;
#pragma 正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName;
#pragma 正则匹配用户身份证号
- (BOOL)checkUserIdCard;
#pragma 正则匹员工号,12位的数字
- (BOOL)checkEmployeeNumber;
#pragma 正则匹配URL
- (BOOL)checkURL;



@end
