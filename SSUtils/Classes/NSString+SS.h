//
//  NSString+SS.h
//  SSDatabaseDemo
//
//  Created by su on 16/7/1.
//  Copyright © 2016年 SS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SS)

#pragma mark - format
- (NSString *)md5;
- (NSString *)trim;
- (NSString *)urlDecode;
- (NSString *)urlEncode;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;


#pragma mark - transform 转成其他数据类型
- (NSDate *) dateForFormat:(NSString *)format;

- (NSData *) data;


#pragma mark - verify
- (BOOL) isEmail;
- (BOOL) hasSubString:(NSString *)sub;

@end
