//
//  SignatrueEncryption.m
//  Tuantuangou
//
//  Created by Duke on 13-6-3.
//  Copyright (c) 2013年 Duke. All rights reserved.
//

#import "SignatrueEncryption.h"
#import <CommonCrypto/CommonDigest.h>
#import "CommonDefine.h"
#import "NSString+Encrypto.h"

@implementation SignatrueEncryption

+ (NSMutableDictionary *)encryptedParamsWithBaseParams:(NSMutableDictionary *)paramsDictionary
{
    NSMutableString *signatrueString = [NSMutableString stringWithString:kAPP_KEY];
    //将参数字典排序
    NSArray *sortedParamsDictionaryKeys = [[paramsDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *oneKey in sortedParamsDictionaryKeys) {
        [signatrueString appendFormat:@"%@%@", oneKey, [paramsDictionary objectForKey:oneKey]];
    }

    [signatrueString appendString:kAPP_SECRET];
    NSMutableDictionary *newParamsDictionary = [NSMutableDictionary dictionaryWithDictionary:paramsDictionary];
    [newParamsDictionary setObject:[signatrueString sha1] forKey:@"sign"];
    return newParamsDictionary;
}

@end
