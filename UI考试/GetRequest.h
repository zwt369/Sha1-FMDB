//
//  GetRequest.h
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^blockRequest)(NSData* data);

@interface GetRequest : NSObject

//网络请求封装
+ (void)getRequestURL:(NSString *)URL block:(void(^)(NSData* data))requestBlock;


@end
