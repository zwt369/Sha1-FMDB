//
//  Categories.h
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MemorandumFile @"Memorandum.sqlite"
@interface Categories : NSObject

@property(nonatomic,strong)NSArray * categories;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *commodityDescription;
@property (nonatomic ,strong)NSString *s_image_url;

@end
