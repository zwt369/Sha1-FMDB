//
//  DataBaseManager.h
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Categories;


@interface DataBaseManager : NSObject

+(instancetype)shareDataBase;

-(void)creatTableWithString:(NSString *)string;

-(void)insertDataWithString:(NSString *)string andCategories:(NSString *)categories andModle:(Categories *)modle;

-(NSDictionary *)queryDataModleWithString:(NSString *)string;

@end
