//
//  GetRequest.m
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "GetRequest.h"

@implementation GetRequest

+ (void)getRequestURL:(NSString *)URL block:(void(^)(NSData* data))requestBlock{
    NSURL *url = [NSURL URLWithString:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *task =[session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //block回调
                if (requestBlock) {
                    requestBlock(data);
                }
            });
        }
    }];
    [task resume];
}



@end
