//
//  UserAddressBook.m
//  MeiYueFu
//
//  Created by 拾光 on 15/11/3.
//  Copyright © 2015年 拾光 All rights reserved.
//

#import "UserAddressBook.h"
#import <AddressBook/AddressBook.h>
@implementation UserAddressBook

//+(void)ReadAllPeoples
//
//{
//    
//    //取得本地通信录名柄
//    
//    ABAddressBookRef tmpAddressBook = ABAddressBookCreate();
//    
//    //取得本地所有联系人记录
//    
//    NSArray* tmpPeoples = (NSArray*)CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(tmpAddressBook));
//    
//    NSMutableArray * array = [NSMutableArray array];
//    
//    for(id tmpPerson in tmpPeoples)
//        
//    {
//        
//        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//        
//        //获取的联系人单一属性:First name
//        
//        NSString* tmpFirstName = (NSString*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonFirstNameProperty));
//        
//        NSLog(@"First name:%@", tmpFirstName);
//        [dict setObject:tmpFirstName forKey:@"tmpFirstName"];
//
//        
//        //获取的联系人单一属性:Last name
//        
//        NSString* tmpLastName = (NSString*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonLastNameProperty));
//        
//        NSLog(@"Last name:%@", tmpLastName);
//        
//        [dict setObject:tmpLastName forKey:@"tmpLastName"];
//
//        //获取的联系人单一属性:Nickname
//        
//        NSString* tmpNickname = (NSString*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonNicknameProperty));
//        
//        NSLog(@"Nickname:%@", tmpNickname);
//        [dict setObject:tmpNickname forKey:@"tmpNickname"];
//
//        
//        //获取的联系人单一属性:Company name
//        
//        NSString* tmpCompanyname = (NSString*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonOrganizationProperty));
//        
//        NSLog(@"Company name:%@", tmpCompanyname);
//        [dict setObject:tmpCompanyname forKey:@"tmpCompanyname"];
//
//        
//        //获取的联系人单一属性:Job Title
//        
//        NSString* tmpJobTitle= (NSString*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonJobTitleProperty));
//        
//        NSLog(@"Job Title:%@", tmpJobTitle);
//        [dict setObject:tmpJobTitle forKey:@"tmpJobTitle"];
//
//        
//        //获取的联系人单一属性:Department name
//        
//        NSString* tmpDepartmentName = (NSString*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonDepartmentProperty));
//        
//        NSLog(@"Department name:%@", tmpDepartmentName);
//        [dict setObject:tmpDepartmentName forKey:@"tmpDepartmentName"];
//
//        //获取的联系人单一属性:Email(s)
//        
//        ABMultiValueRef tmpEmails = ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonEmailProperty);
//        
//        for(NSInteger j = 0; ABMultiValueGetCount(tmpEmails); j++)
//            
//        {
//            
//            NSString* tmpEmailIndex = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(tmpEmails, j));
//            
//            NSLog(@"Emails%d:%@", j, tmpEmailIndex);
//
//            
//        }
//        
//        CFRelease(tmpEmails);
//        
//        //获取的联系人单一属性:Birthday
//        
//        NSDate* tmpBirthday = (NSDate*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonBirthdayProperty));
//        
//        NSLog(@"Birthday:%@", tmpBirthday);
//        
//        [dict setObject:tmpBirthday forKey:@"tmpBirthday"];
//
//        //获取的联系人单一属性:Note
//        
//        NSString* tmpNote = (NSString*)CFBridgingRelease(ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonNoteProperty));
//        
//        NSLog(@"Note:%@", tmpNote);
//        [dict setObject:tmpNote forKey:@"tmpNote"];
//
//        
//        //获取的联系人单一属性:Generic phone number
//        
//        ABMultiValueRef tmpPhones = ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonPhoneProperty);
//        
//        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
//            
//        {
//            
//            NSString* tmpPhoneIndex = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(tmpPhones, j));
//            
//            NSLog(@"tmpPhoneIndex%d:%@", j, tmpPhoneIndex);
//            
//            
//        }
//        
//        CFRelease(tmpPhones);
//        [array addObject:dict];
//
//    }
//    
//    NSLog(@"%@",array);
//    //释放内存
//    
//    CFRelease(tmpAddressBook);
//    
//}

+(NSDictionary*)getLinkManDict{
    CFErrorRef error = NULL;

    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus == kABAuthorizationStatusAuthorized || authStatus == kABAuthorizationStatusNotDetermined)
    {
        NSMutableDictionary * infoDict = [[NSMutableDictionary alloc] init];
        
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){                                                     dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        
        //取得本地所有联系人记录
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
        for(int i = 0; i < CFArrayGetCount(results); i++)
        {
            NSMutableDictionary *dicInfoLocal = [NSMutableDictionary dictionaryWithCapacity:0];
            
            ABRecordRef person = CFArrayGetValueAtIndex(results, i);
#pragma mark    读取姓名
            NSString *first = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            if (first==nil) {
                first = @"";
            }
            NSString *last = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
            if (last == nil) {
                last = @"";
            }
            NSString *name = [NSString stringWithFormat:@"%@%@",last,first];
            [dicInfoLocal setObject:name forKey:@"name"];
            
//#pragma mark    读取昵称
//            NSString* nickName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonNicknameProperty);
//            if (nickName != nil) {
//                [dicInfoLocal setObject:nickName forKey:@"nickName"];
//            }
//            
//#pragma mark    读取公司名称
//            NSString* companyName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
//            if (companyName != nil) {
//                [dicInfoLocal setObject:companyName forKey:@"companyName"];
//            }
//            
//#pragma mark    读取工作职称
//            NSString* position = (__bridge NSString *)ABRecordCopyValue(person, kABPersonJobTitleProperty);
//            if (position != nil) {
//                [dicInfoLocal setObject:position forKey:@"position"];
//            }
//            
//#pragma mark    读取地址
//            ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
//            int count = (int)ABMultiValueGetCount(address);
//            
//            for(int j = 0; j < count; j++)
//            {
//                NSMutableString * addressStr = [NSMutableString string];
//                NSString* addressLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(address, j);
//                if(addressLabel != nil)//国家
//                    [addressStr appendString:addressLabel];
//
//                //获取該label下的地址6属性
//                NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
//                NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
//                if(country != nil)//国家
//                    [addressStr appendString:country];
//                NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
//                if(city != nil)//城市
//                    [addressStr appendString:city];
//                
//                NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
//                if(state != nil)//省
//                    [addressStr appendString:state];
//                
//                NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
//                if(street != nil)//街道
//                    [addressStr appendString:street];
//                
//                NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
//                if(zip != nil)//邮编
//                    [addressStr appendString:zip];
//                
//                NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
//                if(coutntrycode != nil)//国家编号
//                    [addressStr appendString:coutntrycode];
//                
//                [dicInfoLocal setObject:addressStr forKey:[NSString stringWithFormat:@"address%d",j]];
//                
//            }
//            
//#pragma mark  获取邮箱
//            ABMultiValueRef tmpEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
//            for(int j = 0; j<ABMultiValueGetCount(tmpEmails); j++)
//            {
//                NSString* tmpEmail = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpEmails, j);
//                if (tmpEmail !=nil) {
//                    [dicInfoLocal setObject:tmpEmail forKey:[NSString stringWithFormat:@"email%d",j]];
//                    
//                }
//                
//            }
//            CFRelease(tmpEmails);
            
#pragma mark  获取通讯录
            ABMultiValueRef tmlphones =  ABRecordCopyValue(person, kABPersonPhoneProperty);
            for(int k = 0; k < ABMultiValueGetCount(tmlphones); k++)
            {
                
                NSString* telphone = [UserAddressBook filterDataString:(__bridge NSString*)ABMultiValueCopyValueAtIndex(tmlphones, k)];
                [dicInfoLocal setObject:telphone forKey:[NSString stringWithFormat:@"telephone%d",k]];
                
                //每个电话存一个key
                [infoDict setObject:dicInfoLocal forKey:telphone];
                if (k >= 5) {
                    break;
                }
            }
            CFRelease(tmlphones);
        }
        CFRelease(results);//new
        CFRelease(addressBook);//new
        
        return infoDict;
    }
    return @{};
}

+(NSString*)filterDataString:(NSString*)string{
    
    NSString * returnStr = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return returnStr;
    
}


@end
