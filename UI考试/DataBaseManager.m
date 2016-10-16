//
//  DataBaseManager.m
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "DataBaseManager.h"
#import <FMDB.h>
#import "Categories.h"

static DataBaseManager *dataBaseM =nil;
static NSString *myBaseName = @"mydata.sqlite";
static FMDatabase *db =nil;

@implementation DataBaseManager

+(instancetype)shareDataBase{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBaseM=[[DataBaseManager alloc]init];
    });

    return dataBaseM;
}


-(void)creatTableWithString:(NSString *)string{
   
    if (![db open]) {
         [self openDB];
    }
    NSString *str =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (categories TEXT NOT NULL, title TEXT NOT NULL,description TEXT NOT NULL,pictUrl TEXT NOT NULL)",string];
    BOOL result =[db executeUpdate:str];
    
    if (result) {
        NSLog(@"创表成功");
    }else{
        
        NSLog(@"创表失败");
    }
    [db close];
}


/*
 *  如果数据库没有打开，先打开数据再进行操作
 */
- (void)openDB{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:myBaseName];
    db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    [db open];
}

-(void)insertDataWithString:(NSString *)string andCategories:(NSString *)categories andModle:(Categories *)modle{

   //    NSMutableArray *array = [NSMutableArray array];
//    NSString *str =[NSString stringWithFormat:@"select *from %@",string];
//    FMResultSet *set = [db executeQuery:str];
//    while ([set next]) {
//        NSString *user_name = [set stringForColumn:modle.title];
//        [array addObject:user_name];
//    }
    NSDictionary *dic = [self queryDataModleWithString:string];
    NSArray *array = dic[string];
    for (NSDictionary *dict in array) {
        NSString *str = dict[@"title"];
        if ([str isEqualToString:modle.title]) {
            return;
        }
    }
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:myBaseName];
    db = [FMDatabase databaseWithPath:filePath];
    if (![db open]) {
        [self openDB];
    }

    NSString *str0 =[NSString stringWithFormat:@"insert into %@ (categories,title,description,pictUrl) values(?,?,?,?)",string];
    [db executeUpdate:str0,categories,modle.title,modle.commodityDescription,modle.s_image_url];

    [db close];
}


-(NSDictionary *)queryDataModleWithString:(NSString *)string{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:myBaseName];
    db = [FMDatabase databaseWithPath:filePath];
    if (![db open]) {
        [self openDB];
    }
    NSMutableArray *array=[NSMutableArray array];
    NSString *str = [NSString stringWithFormat:@"select *from %@",string];
    FMResultSet *set =[db executeQuery:str];
    while ([set next]) {
        NSString *categories = [set stringForColumn:@"categories"];
        NSString *title = [set stringForColumn:@"title"];
        NSString *description = [set stringForColumn:@"description"];
        NSString *pictUrl = [set stringForColumn:@"pictUrl"];
        NSMutableDictionary *user = [NSMutableDictionary new];
        [user setObject:categories forKey:@"categories"];
        [user setObject:title forKey:@"title"];
        [user setObject:description forKey:@"description"];
        [user setObject:pictUrl forKey:@"pictUrl"];
        [array addObject:user];
    }
    NSDictionary *dict = @{string:array};
    [db close];
    return dict;
}



@end
