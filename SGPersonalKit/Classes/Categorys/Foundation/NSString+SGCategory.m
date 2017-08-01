//
//  NSString+SGCategory.m
//  DoctorPost
//
//  Created by 卢旭宇 on 15/6/10.
//  Copyright (c) 2015年 sg. All rights reserved.
//

#import "NSString+SGCategory.h"
@implementation NSString (SGCategory)

-(NSString*)moneyStr{
    NSString * string = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"，" withString:@""];
    return string;
}
-(NSString*)conciseFloatStr{
    
    NSMutableString * string = [NSMutableString stringWithString:self];
    while ([string rangeOfString:@"."].location != NSNotFound) {
        if ([string hasSuffix:@"."] || [string hasSuffix:@"0"]) {
            [string deleteCharactersInRange:NSMakeRange(string.length -1, 1)];
        }
        else{
            break;
        }
    }
    return string;
}

-(NSAttributedString*)strikeThroughLineWithColor:(UIColor*)color{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self];
    
    [attString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attString.length)];
    [attString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attString.length)];
    [attString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attString.length)];

    return attString;
}

- (NSMutableAttributedString*)addAttribute:(NSString *)name value:(id)value range:(NSRange)range{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self];
    [attString addAttribute:name value:value range:range];
    
    return attString;
}


- (BOOL)isNumText{
    //判断是不是纯数字
    [NSCharacterSet decimalDigitCharacterSet];
    if ([[self stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]]trimming].length >0) {
        return NO;
    }else{
        return YES;
    }
}

- (NSString *) trimming {
    
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isAValidChinaMobileNumber
{
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


-(NSUInteger) unicodeLength{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {
        
        unichar uc = [self characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength / 2;
    
    if(asciiLength % 2) {
        unicodeLength++;
    }
    
    return unicodeLength;
}


- (CGSize)sizeWithFont:(UIFont *)font sizeRange:(CGSize)size
{
    CGSize resultSize;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_7_0
    resultSize =  [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#endif
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    resultSize = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
#endif
    return resultSize;

}

-(BOOL)isChinese:(NSString*)text{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4E00-\u9FA5]*$"];
    BOOL NoNumber =  [predicate evaluateWithObject:text];
    return NoNumber;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL back =[emailTest evaluateWithObject:email];
    return back;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{9}$";
    NSString *mobileRegex = @"^1+[34578]{1}+[0-9]{9}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    BOOL back =[mobileTest evaluateWithObject:mobile];
    
//    BOOL first =[[mobile substringToIndex:1]isEqualToString:@"1"];
//    BOOL length =[mobile length]==11;
//    if (first && length) {
//        return YES;
//    }
    return back;
}

+(BOOL)isLetterAndChinese:(NSString*)text{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[A-Za-z\u4E00-\u9FA5]*$"];
    BOOL NoNumber =  [predicate evaluateWithObject:text];
    return NoNumber;
}



#pragma 正则匹配手机号
- (BOOL)checkTelNumber
{
    NSString *pattern = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


#pragma 正则匹配用户密码6-12位数字和字母组合
- (BOOL)checkPassword
{//(?![0-9]+$)(?![a-zA-Z]+$)
    NSString *pattern = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z\\d]{6,12}$";

//        NSString *pattern = @"^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)[a-zA-Z0-9]{6,12}";
//        NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
- (BOOL)checkUserIdCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
- (BOOL)checkEmployeeNumber
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

#pragma 正则匹配URL
- (BOOL)checkURL
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

@end
