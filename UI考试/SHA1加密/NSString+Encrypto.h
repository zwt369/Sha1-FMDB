//
//  NSString+Encrypto.h
//  UI考试
//
//  Created by Tony Zhang on 16/7/15.
//  Copyright © 2016年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypto)

- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;

@end
