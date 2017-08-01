//
//  NSArray+SGCategory.m
//  MeiYueFu
//
//  Created by 拾光 on 16/4/15.
//  Copyright © 2016年 拾光 All rights reserved.
//

#import "NSArray+SGCategory.h"
#import <UIKit/UIKit.h>
#import "YYModel.h"
@implementation NSArray (SGCategory)

-(id)objectAtIndexPath:(NSIndexPath*)indexPath{
    if (self.count == 0) {
        return nil;
    }
    return [[self objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}


-(NSArray*)yy_modelArrayCopy {
    
    NSMutableArray * array = [NSMutableArray array];
    for (id obj in self) {
        id model = [obj yy_modelCopy];
        [array addObject:model];
    }
    
    return array;
}

@end
