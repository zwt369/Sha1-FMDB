//
//  Categories.m
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "Categories.h"

@implementation Categories

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        _commodityDescription = value;
    }
}



@end
